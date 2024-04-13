extends Node2D

var number: int
var element: int
var status: int

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_active(false)
	infuse_element(Elements.Base)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active(active):
	status = active
	visible = active

func infuse_element(new_element: int):
	element = new_element
	sprite.infuse_element(new_element)

func round_passive():
	match element:
		Elements.Base:
			return
		_:
			return
