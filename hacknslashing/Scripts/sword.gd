extends Node2D

@onready var sword_animated_sprite = $AnimatedSprite2D
@onready var attackCooldownTimer: Timer = null
var sword_distance: float = 32
var mouseInput
var attackCooldown: float = 1.5
var canAttack: bool = true : set = set_canAttack, get = get_canAttack


func set_canAttack(value : bool):
	canAttack = value

func get_canAttack() -> bool:
	return canAttack

func _ready() -> void:
	attackCooldownTimer = Timer.new()
	add_child(attackCooldownTimer)
	attackCooldownTimer.one_shot = true
	attackCooldownTimer.wait_time = attackCooldown
	attackCooldownTimer.timeout.connect(set_canAttack.bind(true))

func _process(delta):
	#add attackcooldown
	#look into the other "action pressed" methods if this doesnt feel right
	
	if Input.is_action_pressed("attack", false) && canAttack:
		canAttack = false
		attackCooldownTimer.start()
		print("wow")
	
	var mouse_position = get_global_mouse_position()
	# Calculate the direction vector from the player to the mouse
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()
	
	# Calculate the new position of the sword based on the angle
	var sword_position = Vector2(cos(angle), sin(angle)) * sword_distance
	# Set the sword position relative to the player
	sword_animated_sprite.position = sword_position
	
	# Set the swordsprite based on the angle
	if angle > -PI/8 and angle <= PI/8:
		# Right
		sword_animated_sprite.play("idle_horizontal")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = false
	elif angle > PI/8 and angle <= 3*PI/8:
		# Down-Right
		sword_animated_sprite.play("idle_diagonal")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = true
	elif angle > 3*PI/8 and angle <= 5*PI/8:
		# Down
		sword_animated_sprite.play("idle_vertical")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = true
	elif angle > 5*PI/8 and angle <= 7*PI/8:
		# Down-Left
		sword_animated_sprite.play("idle_diagonal")
		sword_animated_sprite.flip_h = true
		sword_animated_sprite.flip_v = true
	elif angle > 7*PI/8 or angle <= -7*PI/8:
		# Left
		sword_animated_sprite.play("idle_horizontal")
		sword_animated_sprite.flip_h = true
		sword_animated_sprite.flip_v = false
	elif angle > -7*PI/8 and angle <= -5*PI/8:
		# Up-Left
		sword_animated_sprite.play("idle_diagonal")
		sword_animated_sprite.flip_h = true
		sword_animated_sprite.flip_v = false
	elif angle > -5*PI/8 and angle <= -3*PI/8:
		# Up
		sword_animated_sprite.play("idle_vertical")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = false
	elif angle > -3*PI/8 and angle <= -PI/8:
		# Up-Right
		sword_animated_sprite.play("idle_diagonal")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = false
