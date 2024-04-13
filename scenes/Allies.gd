extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var player = $Player
@onready var slime = $Slime
@onready var slime2 = $Slime2
@onready var slime3 = $Slime3


func _ready():
	pass # Replace with function body.
	slime.number=1
	slime2.number=2
	slime3.number=3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
