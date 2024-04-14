extends Node2D

@onready var human = $Human
@onready var combat_flow = $"../../CombatFlow"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enemy_turn():
	print("Enemy turn")
	combat_flow.set_phase(Phase.Slimes)
	
