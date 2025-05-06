extends Node2D

@onready var sword_animated_sprite = $AnimatedSprite2D
@onready var attack_cooldown_timer: Timer = null

# Width of the oval
var sword_distance_x: int = 24
# Height of the oval
var sword_distance_y: int = 30
var attack_cooldown: float = 1.5
var is_attacking: bool = false : set = set_is_attacking, get = get_is_attacking
var can_attack: bool = true : set = set_can_attack, get = get_can_attack

func set_is_attacking(value : bool):
	is_attacking = value

func get_is_attacking() -> bool:
	return is_attacking

func set_can_attack(value : bool):
	can_attack = value

func get_can_attack() -> bool:
	return can_attack

func _ready() -> void:
	attack_cooldown_timer = Timer.new()
	add_child(attack_cooldown_timer)
	attack_cooldown_timer.one_shot = true
	attack_cooldown_timer.wait_time = attack_cooldown
	attack_cooldown_timer.timeout.connect(set_can_attack.bind(true))
	sword_animated_sprite.animation_finished.connect(on_animation_finished)

func _process(delta):
	#look into the other "action pressed" methods if this doesnt feel right
	var result = get_animation_specifics()
	if Input.is_action_pressed("attack", false) && can_attack:
		is_attacking = true
		can_attack = false
		attack_cooldown_timer.start()
		#change the horizontal attack sprites because it is in the wrong direction rightnow
		attack(result)
	elif !is_attacking:
		idle(result)

func on_animation_finished() -> void:
	if sword_animated_sprite.animation == "attack_vertical" || sword_animated_sprite.animation == "attack_horizontal" || sword_animated_sprite.animation == "attack_diagonal":
		is_attacking = false

func attack(angle) -> void:
	print("attacked")
	if angle > -PI/8 and angle <= PI/8:
		# Right
		sword_animated_sprite.play("attack_horizontal")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = false
	elif angle > PI/8 and angle <= 3*PI/8:
		# Down-Right
		sword_animated_sprite.play("attack_diagonal")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = true
	elif angle > 3*PI/8 and angle <= 5*PI/8:
		# Down
		sword_animated_sprite.play("attack_vertical")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = true
	elif angle > 5*PI/8 and angle <= 7*PI/8:
		# Down-Left
		sword_animated_sprite.play("attack_diagonal")
		sword_animated_sprite.flip_h = true
		sword_animated_sprite.flip_v = true
	elif angle > 7*PI/8 or angle <= -7*PI/8:
		# Left
		sword_animated_sprite.play("attack_horizontal")
		sword_animated_sprite.flip_h = true
		sword_animated_sprite.flip_v = false
	elif angle > -7*PI/8 and angle <= -5*PI/8:
		# Up-Left
		sword_animated_sprite.play("attack_diagonal")
		sword_animated_sprite.flip_h = true
		sword_animated_sprite.flip_v = false
	elif angle > -5*PI/8 and angle <= -3*PI/8:
		# Up
		sword_animated_sprite.play("attack_vertical")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = false
	elif angle > -3*PI/8 and angle <= -PI/8:
		# Up-Right
		sword_animated_sprite.play("attack_diagonal")
		sword_animated_sprite.flip_h = false
		sword_animated_sprite.flip_v = false

func idle(angle) -> void:
	# Set the swordanimatedsprite based on the angle
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

func get_animation_specifics():
	var mouse_position = get_global_mouse_position()
	# Calculate the direction vector from the player to the mouse
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()
	
	# Calculate the new position of the sword based on the angle
	var sword_position = Vector2(cos(angle) * sword_distance_x, sin(angle) * sword_distance_y)
	sword_animated_sprite.position = sword_position
	return angle
