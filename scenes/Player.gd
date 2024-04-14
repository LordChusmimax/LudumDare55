extends Node2D

@onready var buffs = $Buffs
@onready var health = $Health
@onready var armor = $Buffs/HFlowContainer/Armor
@onready var frozen = $Buffs/HFlowContainer/Frozen
@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dead():
	print("You Lose")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(number,blockable):
	if frozen.stacks>0:
		number *= 1.5
	if blockable:
		if armor.stacks > number:
			armor.upgrade(-number)
		else:
			armor.upgrade(-armor.stacks)
			health.damage(number-armor.stacks)
	else:
		health.damage(number)
