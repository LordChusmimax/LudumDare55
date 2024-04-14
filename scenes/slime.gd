extends Node2D

class_name Slime

var number: int
var element: int
var status: int

@onready var sprite = $AnimatedSprite2D
@onready var buffs = $Buffs
@onready var health = $Health
@onready var armor = $Buffs/HFlowContainer/Armor
@onready var frozen = $Buffs/HFlowContainer/Frozen

# Called when the node enters the scene tree for the first time.
func _ready():
	set_active(Status.Inactive)
	infuse_element(Elements.Base)
	pass # Replace with function body.


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

func dead():
	health.full_heal()
	clear_buffs()
	set_active(Status.Inactive)

func set_active(active: int):
	status = active
	if active == Status.Inactive:
		visible = false
		infuse_element(Elements.Base)
		health.full_heal()
		clear_buffs()
	else:
		visible = true

func clear_buffs():
	for buff in buffs.buffs:
		buff.upgrade(-buff.stacks)

func infuse_element(new_element: int):
	element = new_element
	sprite.infuse_element(new_element)

func round_passive():
	match element:
		Elements.Base:
			return
		Elements.Earth:
			Allies.current.apply_buff(Buff.Type.Blocked,6)
		Elements.Fire:
			Enemies.current.apply_buff(Buff.Type.Ignited,2)
		Elements.Ice:
			Enemies.current.apply_buff(Buff.Type.Frozen,2)
		Elements.Thunder:
			Enemies.current.apply_buff(Buff.Type.Shocked,5)
		_:
			return
			
func kick_effect():
	match element:
		Elements.Base:
			Enemies.current.damage_all(5,true)
			return
		Elements.Earth:
			Enemies.current.damage_all(15,true)
		Elements.Fire:
			Enemies.current.damage_all(7,true)
			Enemies.current.apply_buff(Buff.Type.Ignited,5)
		Elements.Ice:
			Enemies.current.damage_all(7,true)
			Enemies.current.apply_buff(Buff.Type.Frozen,2)
		Elements.Thunder:
			Enemies.current.damage_all(7,true)
			Enemies.current.apply_buff(Buff.Type.Shocked,10)
		_:
			return
