extends Control

@onready var allies = $"../Combatants/Allies"
@onready var buttons = [$HBoxContainer/Fire, $HBoxContainer/Ice, $HBoxContainer/Thunder, $HBoxContainer/Earth]
@onready var control = $"../Control"

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	buttons[0].connect("button_up",_on_pressed_0)
	buttons[1].connect("button_up",_on_pressed_1)
	buttons[2].connect("button_up",_on_pressed_2)
	buttons[3].connect("button_up",_on_pressed_3)
	pass # Replace with function body.

func _on_pressed_0():
	CombatMenu.selected_element=Elements.Fire
	element_selected()
	pass

func _on_pressed_1():
	CombatMenu.selected_element=Elements.Ice
	element_selected()
	pass

func _on_pressed_2():
	CombatMenu.selected_element=Elements.Thunder
	element_selected()
	pass
	
func _on_pressed_3():
	CombatMenu.selected_element=Elements.Earth
	element_selected()
	pass

func element_selected():
	control.foward_infuse()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_visibility(argument):
	visible = argument

func disable_buttons(value):
	for button in buttons:
		button.disabled = value
