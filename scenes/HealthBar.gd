extends Node2D

class_name Health

var max_health = 40
var health
@onready var progress_bar = $ProgressBar
@onready var label = $ProgressBar/Label
@onready var user = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	update_health()
	pass # Replace with function body.

func update_health():
	progress_bar.max_value = max_health
	progress_bar.value = health
	label.text = str(health) + "/" + str(max_health)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(number):
	health -= number
	update_health()
	if health <= 0:
		user.dead()
		
func full_heal():
	health = max_health
	update_health()
