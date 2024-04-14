extends Node2D

@onready var buffs = $Buffs
@onready var health = $Health
@onready var armor = $Buffs/HFlowContainer/Armor
@onready var frozen = $Buffs/HFlowContainer/Frozen
@onready var sprite = $AnimatedSprite2D

var round:int

# Called when the node enters the scene tree for the first time.
func _ready():
	round = 0
	pass # Replace with function body.

func turn():
	for buff in buffs.buffs:
		buff.passive()
	
	if buffs.stunned.stacks >= 1:
		buffs.stunned.upgrade(-buffs.stunned.stacks)
		Notifications.current.change_notification("Enemy Stunned")
		await get_tree().create_timer(2).timeout
	else:
		var rand_number = randi_range(0,7)
		if round == 0 and rand_number == 4:
			rand_number = 3
		match rand_number:
			0:
				Notifications.current.change_notification("Human defended herself")
				SoundManager.current.buff.play()
				armor.upgrade(3)
				await get_tree().create_timer(1).timeout
				
				
			1:
				Notifications.current.change_notification("Human cleansed herself from debuffs")
				buffs.cleanse()
				SoundManager.current.buff.play()
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human cleansed herself from debuffs")
			
			2:
				Notifications.current.change_notification("Human hit everyone")
				Allies.current.damage_all(3, true)
				SoundManager.current.hit.play()
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human hit everyone")
			
			
			3:
				Notifications.current.change_notification("Human hit everyone hard")
				Allies.current.damage_all(6, true)
				SoundManager.current.hit.play()
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human hit everyone hard")
				
			4:
				Notifications.current.change_notification("Human hit everyone with poison")
				Allies.current.damage_all(3, true)
				SoundManager.current.hit.play()
				Allies.current.apply_buff(Buff.Type.Poisoned, 3)
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human hit everyone with poison")
				
			5:
				Notifications.current.change_notification("Human hit everyone")
				Allies.current.damage_all(2, true)
				SoundManager.current.hit.play()
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human hit everyone")
				
			6:
				Notifications.current.change_notification("Human hit everyone")
				Allies.current.damage_all(2, true)
				SoundManager.current.hit.play()
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human hit everyone")
				
			7:
				Notifications.current.change_notification("Human hit everyone")
				Allies.current.damage_all(2, true)
				SoundManager.current.hit.play()
				await get_tree().create_timer(1).timeout
				Notifications.current.change_notification("Human hit everyone")
	round += 1
	return true

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
		
func dead():
	Win.current.visible = true
