extends Node2D


# Called when the node enters the scene tree for the first time.
var phase: int
var waiting: bool = true
@onready var combatants = $"../Combatants"
@onready var control = $"../Control"
@onready var allies = $"../Combatants/Allies"
@onready var enemies = $"../Combatants/Enemies"


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if waiting:
		_round()

func enemy_turn():
	enemies.enemy_turn()
	
func player_turn():
	control.visible = true
	control.disable_buttons()
	if not allies.only_slimes():
		control.summon.disabled = false
	if not allies.no_slimes():
		control.infuse.disabled = false
		control.kick.disabled = false
	
func slimes_turn():
	set_phase(Phase.Player)
	
func set_phase(new_phase):
	waiting = true
	phase = new_phase

func _round():
	waiting = false
	match phase:
		Phase.Enemy:
			enemy_turn()
		Phase.Player:
			player_turn()
		Phase.Slimes:
			slimes_turn()
