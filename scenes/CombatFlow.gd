extends Node2D


# Called when the node enters the scene tree for the first time.
var phase: int
var waiting: bool = true
@onready var combatants = $"../Combatants"
@onready var control = $"../Control"
@onready var allies = $"../Combatants/Allies"
@onready var enemies = $"../Combatants/Enemies"
@onready var intro = $"../../Intro"
@onready var notifications = $"../Notifications"
@onready var goblin = $"../../Goblin"
@onready var run = $"../../Run"
@onready var music = $"../../Music"

func _ready():
	set_phase(Phase.Initial)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if waiting:
		_round()

func enemy_turn():
	control.visible = false
	enemies.enemy_turn()
	
func player_turn():
	control.visible = true
	control.disable_buttons()
	control.pass_button.disabled = false
	if not allies.only_slimes():
		control.summon.disabled = false
	if not allies.no_slimes():
		control.infuse.disabled = false
		control.kick.disabled = false
	
func slimes_turn():
	control.visible = false
	allies.slimes_turn()
	
func set_phase(new_phase):
	waiting = true
	phase = new_phase
	
func prefight():
	pass
	
func initiate():
	control.visible = false
	run.visible = false
	intro.visible = true
	allies.player.health.visible = false
	enemies.human.health.visible = false
	enemies.human.sprite.animation = "Fall"
	notifications.visible = false
	
	
	await get_tree().create_timer(6).timeout
	run.visible = true
	
	
	await get_tree().create_timer(1).timeout
	goblin.sprite.animation = "Run"
	goblin.run()
	enemies.human.sprite.animation = "Look"
	
	await get_tree().create_timer(1).timeout
	run.visible = false
	
	await get_tree().create_timer(3).timeout
	allies.player.health.visible = true
	enemies.human.health.visible = true
	enemies.human.sprite.animation = "Idle"
	notifications.visible = true
	set_phase(Phase.Player)
	music.play()

func _round():
	waiting = false
	match phase:
		Phase.Initial:
			initiate()
		Phase.Prefight:
			prefight()
		Phase.Enemy:
			enemy_turn()
		Phase.Player:
			player_turn()
		Phase.Slimes:
			slimes_turn()
