extends Button

@onready var texture_rect = $"../TextureRect"
@onready var label = $"../Label"
@onready var label_2 = $"../Label2"
@onready var label_3 = $"../Label3"
@onready var button = $"."
@onready var tutorial = $"../Panel/Tutorial"


@onready var elements = [$"../TextureRect", $"../Label", $"../Label2", $"../Label3", $"."]

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("button_up",_on_pressed)
	tutorial.connect("button_up",_on_tutorial)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	for control in elements:
		control.visible = false

func _on_tutorial():
	for control in elements:
		control.visible = true
