extends Control

class_name CombatMenu

@onready var summon = $HBoxContainer/Summon
@onready var infuse = $HBoxContainer/Infuse
@onready var kick = $HBoxContainer/Kick
@onready var allies = $"../Combatants/Allies"
@onready var buttons = [$HBoxContainer/Summon,$HBoxContainer/Infuse,$HBoxContainer/Kick]
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
	slime_select.change_visibility(true)
	element_select.change_visibility(true)
	
	slime_select.disable_buttons(false)
	element_select.disable_buttons(true)
	
	disable_buttons()
	foward_infuse()
	
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
			print("abort select elements")
			
func backward_infuse():
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
	
func back_infuse():
	pass
	
func disable_buttons():
	for button in buttons:
		button.disabled = true
		
func enable_buttons():
	combat_flow.player_turn()
