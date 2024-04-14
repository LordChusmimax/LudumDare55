extends Control

class_name Buff
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var label = $Label
@onready var user = $"../../.."

enum Type{
	Shocked,
	Ignited,
	Blocked,
	Frozen,
	Poisoned,
	Stunned
}

var type:int
var stacks:int
# Called when the node enters the scene tree for the first time.
func _ready():
	stacks = 0
	visible = false
	pass # Replace with function body.


func set_type(new_type):
	type = new_type
	match type:
		Type.Ignited:
			animated_sprite_2d.animation = "ignited"
		Type.Shocked:
			animated_sprite_2d.animation = "shocked"
		Type.Poisoned:
			animated_sprite_2d.animation = "poisoned"
		Type.Blocked:
			animated_sprite_2d.animation = "blocked"
		Type.Stunned:
			animated_sprite_2d.animation = "Stunned"
		Type.Frozen:
			animated_sprite_2d.animation = "frozen"

func on_hit():
	match type:
		_:
			pass
			
func on_turn():
	match type:
		_:
			pass
			
func damage(number,blockable):
	user.damage(number,blockable)
	
func passive():
	if stacks<=0:
		visible = false
		return
	match type:
		Type.Ignited:
			label.visible = true
			damage(stacks,true)
			stacks -= 1
			label.text = str(stacks)
		Type.Poisoned:
			label.visible = true
			damage(stacks,false)
			stacks -= 1
			label.text = str(stacks)
		Type.Blocked:
			label.visible = true
			stacks /= 2
			label.text = str(stacks)
		Type.Shocked:
			if stacks >= 0:
				label.visible = true
				stacks -= 1
				label.text = str(stacks)
		_:
			pass
	if stacks<=0:
		visible = false
		return

func upgrade(number):
	stacks += number
	visible = true
	match type:
		Type.Blocked:
			if stacks >= 0:
				label.visible = true
				label.text = str(stacks)
		Type.Ignited:
			if stacks >= 0:
				label.visible = true
				label.text = str(stacks)
		Type.Poisoned:
			if stacks >= 0:
				label.visible = true
				label.text = str(stacks)
		Type.Frozen:
			if stacks >= 0:
				label.visible = true
				label.text = ""
		Type.Shocked:
			if stacks >= 0:
				label.visible = true
				if stacks >=10:
					stacks = 0
					user.buffs.add_buff(Type.Stunned,1)
				label.text = str(stacks)
		Type.Stunned:
			if stacks >= 0:
				label.visible = true
				label.text = ""
		_:
			pass
	if stacks<=0:
		visible = false
	return
