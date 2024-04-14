extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var player = $Player
@onready var slimes = [$Slime,$Slime2,$Slime3]
@onready var battle = $"../.."
@onready var combat_flow = $"../../CombatFlow"


func _ready():
	pass # Replace with function body.
	for i in range(1,3):
		slimes[i].number=i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func summon():
	for slime:Slime in slimes:
		if slime.status == Status.Inactive:
			slime.set_active(Status.OK)
			combat_flow.set_phase(Phase.Enemy)
			return

func only_slimes():
	for slime:Slime in slimes:
		if slime.status == Status.Inactive:
			return false
	return true

func no_slimes():
	for slime:Slime in slimes:
		if slime.status != Status.Inactive:
			return false
	return true
