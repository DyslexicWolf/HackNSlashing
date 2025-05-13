class_name Weapon
extends Node2D

#set these variables in the init function in the child class
var weapon_animated_sprite = null
var attack_cooldown_timer: Timer = null
var weapon_hitbox = null
var player_object = null

# Width of the oval
var weapon_distance_x: int
# Height of the oval
var weapon_distance_y: int
var attack_cooldown: float
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

#call this in _ready function in child classes
func preload_variables() -> void:
	player_object = get_parent()
	attack_cooldown_timer = Timer.new()
	add_child(attack_cooldown_timer)
	attack_cooldown_timer.one_shot = true
	attack_cooldown_timer.wait_time = attack_cooldown
	attack_cooldown_timer.timeout.connect(set_can_attack.bind(true))
	weapon_animated_sprite.animation_finished.connect(on_animation_finished)

#call this in _physics_process function in child classes
func weapon_physics() -> void:
	#look into the other "action pressed" methods if this doesnt feel right
	get_animation_specifics()
	if Input.is_action_pressed("attack", false) && can_attack:
		is_attacking = true
		can_attack = false
		attack_cooldown_timer.start()
		weapon_hitbox.monitoring = true
		weapon_hitbox.monitorable = true
		weapon_animated_sprite.play("attack")
	elif !is_attacking:
		weapon_animated_sprite.play("idle")

func on_animation_finished() -> void:
	if weapon_animated_sprite.animation == "attack":
		weapon_hitbox.monitoring = false
		weapon_hitbox.monitorable = false
		is_attacking = false

func get_animation_specifics():
	var mouse_position = get_global_mouse_position()
	# Calculate the direction vector from the player to the mouse
	var direction = (mouse_position - player_object.position).normalized()
	var angle = direction.angle()
	
	#make the sword look at the mouse position
	weapon_animated_sprite.look_at(get_global_mouse_position())
	weapon_hitbox.look_at(get_global_mouse_position())
	weapon_animated_sprite.rotate(PI/2)
	weapon_hitbox.rotate(PI/2)
	# Calculate the new position of the sword based on the angle
	weapon_animated_sprite.position = Vector2(cos(angle) * weapon_distance_x, sin(angle) * weapon_distance_y)
	weapon_hitbox.position = Vector2(cos(angle) * weapon_distance_x, sin(angle) * weapon_distance_y)
