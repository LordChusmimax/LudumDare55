extends Control

class_name CombatMenu

@onready var summon = $HBoxContainer/Summon
@onready var infuse = $HBoxContainer/Infuse
@onready var kick = $HBoxContainer/Kick
@onready var pass_button = $HBoxContainer/Pass

@onready var allies = $"../Combatants/Allies"
@onready var buttons = [$HBoxContainer/Summon, $HBoxContainer/Infuse, $HBoxContainer/Kick, $HBoxContainer/Pass]
@onready var slime_select = $"../SlimeSelect"
@onready var element_select = $"../ElementSelect"
@onready var combat_flow = $"../CombatFlow"
@onready var back = $back

static var selected_slime : int
static var selected_element : int
var infuse_phase = infuse_phases.None

enum infuse_phases{
	None,
	Selecting_slime,
	Selecting_element
}

# Called when the node enters the scene tree for the first time.
func _ready():
	summon.connect("button_up",_summon)
	infuse.connect("button_up",_infuse)
	kick.connect("button_up",_kick)
	pass_button.connect("button_up",_pass)
	back.connect("button_up",_back)
	back.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _back():
	backward_infuse()

func _summon():
	allies.summon()
	
func _infuse():
	SlimeSelect.infuse_select=true
	
	slime_select.change_visibility(true)
	element_select.change_visibility(true)
	
	slime_select.disable_buttons(false)
	element_select.disable_buttons(true)
	
	disable_buttons()
	foward_infuse()
	
func _kick():
	SlimeSelect.infuse_select=false
	
	slime_select.change_visibility(true)
	
	slime_select.disable_buttons(false)
	
	disable_buttons()
	back.visible = true
	
func _pass():
	combat_flow.set_phase(Phase.Enemy)

func _set_element_menu():
	slime_select.disable_buttons(true)
	element_select.disable_buttons(false)

func foward_infuse():
	match infuse_phase:
		infuse_phases.None:
			infuse_phase = infuse_phases.Selecting_slime
			back.visible = true
		
		infuse_phases.Selecting_slime:
			infuse_phase = infuse_phases.Selecting_element
			_set_element_menu()
		
		infuse_phases.Selecting_element:
			allies.infuse(selected_slime,selected_element)
			infuse_phase = infuse_phases.None
			slime_select.change_visibility(false)
			element_select.change_visibility(false)
			back.visible = false
			
func backward_infuse():
	if !SlimeSelect.infuse_select:
		back.visible = false
		enable_buttons()
		slime_select.change_visibility(false)
		element_select.change_visibility(false)
		return
	
	match infuse_phase:
		infuse_phases.Selecting_slime:
			infuse_phase = infuse_phases.None
			back.visible = false
			enable_buttons()
			slime_select.change_visibility(false)
			element_select.change_visibility(false)
			
		
		infuse_phases.Selecting_element:
			infuse_phase = infuse_phases.Selecting_slime
			slime_select.disable_buttons(false)
			element_select.disable_buttons(true)
		
		infuse_phases.None:
			pass
	
func kicked():
	infuse_phase = infuse_phases.None
	slime_select.change_visibility(false)
	element_select.change_visibility(false)
	
	back.visible = false
	
func back_infuse():
	pass
	
func disable_buttons():
	for button in buttons:
		button.disabled = true
		
func enable_buttons():
	combat_flow.player_turn()

