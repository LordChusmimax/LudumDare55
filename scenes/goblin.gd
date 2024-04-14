extends Node2D

@onready var sprite = $AnimatedSprite2D

var state: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move():
	position = position + Vector2.LEFT

func run():
	state = 1
	
	await get_tree().create_timer(6).timeout
	
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 1:
		move()
	pass
