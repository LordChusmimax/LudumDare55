extends AnimatedSprite2D

var element_dict = {
	Elements.Base : "Idle",
	Elements.Ice : "Ice",
	Elements.Fire : "Fire",
	Elements.Earth : "Earth",
	Elements.Thunder : "Shock"
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func infuse_element(element):
	animation=element_dict[element]
