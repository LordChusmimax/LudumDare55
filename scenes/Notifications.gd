extends Panel
class_name Notifications

@onready var label = $Label

static var current:Notifications

# Called when the node enters the scene tree for the first time.
func _ready():
	current = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_notification(text):
	label.text = text
	await get_tree().create_timer(2).timeout
	label.text = ""
	
