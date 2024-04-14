extends AnimatedSprite2D

class_name Win

static var current: Win
@onready var restart = $Restart

# Called when the node enters the scene tree for the first time.
func _ready():
	current = self
	visible = false
	restart.connect("button_up",_on_menu)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_menu():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
