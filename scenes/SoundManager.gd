extends Node

class_name SoundManager

@onready var summon = $Summon
@onready var hit = $Hit
@onready var kick = $Kick
@onready var infuse = $Infuse
@onready var buff = $Buff

static var current:SoundManager

# Called when the node enters the scene tree for the first time.
func _ready():
	current = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
