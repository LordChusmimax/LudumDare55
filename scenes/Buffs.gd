extends Node2D
var buff_scene = preload("res://UI/Buffs/buff.gd")
@onready var h_flow_container = $HFlowContainer
@onready var ignited = $HFlowContainer/Ignited
@onready var shocked = $HFlowContainer/Shocked
@onready var armor = $HFlowContainer/Armor
@onready var stunned = $HFlowContainer/Stunned
@onready var frozen = $HFlowContainer/Frozen
@onready var poisoned = $HFlowContainer/Poisoned

@onready var buffs = [$HFlowContainer/Ignited, $HFlowContainer/Shocked, $HFlowContainer/Armor, $HFlowContainer/Stunned, $HFlowContainer/Frozen, $HFlowContainer/Poisoned]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_types()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cleanse():
	for buff:Buff in buffs:
		if buff.type != buff.Type.Blocked:
			buff.upgrade(-buff.stacks)

func set_types():
	ignited.set_type(Buff.Type.Ignited)
	shocked.set_type(Buff.Type.Shocked)
	armor.set_type(Buff.Type.Blocked)
	stunned.set_type(Buff.Type.Stunned)
	frozen.set_type(Buff.Type.Frozen)
	poisoned.set_type(Buff.Type.Poisoned)

func add_buff(type, number):
	for buff in buffs:
		if buff.type == type:
			buff.upgrade(number)
