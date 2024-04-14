extends Node2D

class_name Allies

# Called when the node enters the scene tree for the first time.
@onready var player = $Player
@onready var slimes = [$Slime,$Slime2,$Slime3]
@onready var battle = $"../.."
@onready var combat_flow = $"../../CombatFlow"

var summoning :bool = false
static var current: Allies

func _ready():
	current = self
	for i in range(1,3):
		slimes[i].number=i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func summon():
	if summoning == true:
		return
	summoning = true
	SoundManager.current.summon.play()
	for slime:Slime in slimes:
		if slime.status == Status.Inactive:
			slime.set_active(Status.OK)
			slime.clear_buffs()
			player.sprite.animation = "Summon"
			await get_tree().create_timer(1).timeout
			player.sprite.animation = "Idle"
			combat_flow.set_phase(Phase.Enemy)
			summoning = false
			return

func infuse(slime,element):
	SoundManager.current.infuse.play()
	slimes[slime].infuse_element(element)
	player.sprite.animation = "Summon"
	await get_tree().create_timer(1).timeout
	player.sprite.animation = "Idle"
	combat_flow.set_phase(Phase.Enemy)
	return
	
func kick(slime_num):
	SoundManager.current.kick.play()
	var slime :Slime = slimes[slime_num]
	slime.kick_effect()
	slime.set_active(Status.Inactive)
	player.sprite.animation = "Kick"
	await get_tree().create_timer(1).timeout
	player.sprite.animation = "Idle"
	combat_flow.set_phase(Phase.Enemy)
	return

func apply_buff(type,number):
	player.buffs.add_buff(type,number)
	
	for slime in slimes:
		if slime.status != Status.Inactive:
			slime.buffs.add_buff(type,number)

func damage_all(number, blockable):
	player.damage(number,blockable)
	for slime:Slime in slimes:
		if slime.status != Status.Inactive:
			slime.damage(number,blockable)

func slimes_turn():
	for slime:Slime in slimes:
		for buff:Buff in slime.buffs.buffs:
			buff.passive()
		slime.round_passive()
	combat_flow.set_phase(Phase.Player)
	for buff:Buff in player.buffs.buffs:
			buff.passive()

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
