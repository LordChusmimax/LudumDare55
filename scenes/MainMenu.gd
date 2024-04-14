extends Panel

@onready var start = $Start
@onready var tutorial = $Tutorial

# Called when the node enters the scene tree for the first time.
func _ready():
	start.connect("button_up",_on_start)
	tutorial.connect("button_up",_on_tutorial)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_start():
	get_tree().change_scene_to_file("res://scenes/scene.tscn")
	
func _on_tutorial():
	pass
