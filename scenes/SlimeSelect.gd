extends Control

class_name SlimeSelect

@onready var allies = $"../Combatants/Allies"
@onready var buttons = [$HBoxContainer/Slime1, $HBoxContainer/Slime2, $HBoxContainer/Slime3]
@onready var combat_menu = $"../Control"
static var infuse_select

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	buttons[0].connect("button_up",_on_pressed_0)
	buttons[1].connect("button_up",_on_pressed_1)
	buttons[2].connect("button_up",_on_pressed_2)
	pass # Replace with function body.

func _on_pressed_0():
	CombatMenu.selected_slime=0
	slime_selected()
	pass

func _on_pressed_1():
	CombatMenu.selected_slime=1
	slime_selected()
	pass

func _on_pressed_2():
	CombatMenu.selected_slime=2
	slime_selected()
	pass

func slime_selected():
	if infuse_select:
		combat_menu.foward_infuse()
	else:
		allies.kick(CombatMenu.selected_slime)
		combat_menu.kicked()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_visibility(argument):
	visible = argument
	for button in buttons:
		button.visible = false
	for i in range (0,3):
		if allies.slimes[i].status != Status.Inactive:
			buttons[i].visible = true

func disable_buttons(value):
	for button in buttons:
		button.disabled = value
