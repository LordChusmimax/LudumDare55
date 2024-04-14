extends AnimatedSprite2D

class_name Lose

static var current: Lose

@onready var restart = $Restart
@onready var menu = $Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	current = self
	visible = false
	restart.connect("button_up",_on_restart)
	menu.connect("button_up",_on_menu)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_restart():
	get_tree().reload_current_scene()
	
func _on_menu():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
