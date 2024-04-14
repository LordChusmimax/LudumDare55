extends Node2D

class_name Enemies

static var current: Enemies

@onready var human = $Human
@onready var combat_flow = $"../../CombatFlow"

# Called when the node enters the scene tree for the first time.
func _ready():
	current = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enemy_turn():
	await human.turn()
	combat_flow.set_phase(Phase.Slimes)


func apply_buff(type,number):
	human.buffs.add_buff(type,number)
	
func damage_all(number, blockable):
	human.damage(number,blockable)
	
func hide_health(value):
	human.health.visible != value
