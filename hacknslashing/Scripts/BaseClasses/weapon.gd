class_name Weapon
extends Node2D

#set these variables in the init function in the child class
@export var equipped_weapon_data : WeaponResource
@onready var weapon_sprite = $"../WeaponSprite"
var weapon_animation_player = null
var attack_cooldown_timer: Timer = null
@onready var weapon_hitbox = $"../WeaponHitBox"
var player_object = null

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
func _ready() -> void:
	player_object = get_parent()
	attack_cooldown_timer = Timer.new()
	add_child(attack_cooldown_timer)
	attack_cooldown_timer.one_shot = true
	attack_cooldown_timer.timeout.connect(set_can_attack.bind(true))
	_load_weapon(equipped_weapon_data)

func _load_weapon(new_weapon_data : WeaponResource):
	equipped_weapon_data = new_weapon_data
	attack_cooldown_timer.wait_time = equipped_weapon_data.attack_cooldown
	weapon_animation_player = $"../WeaponAnimationPlayer"
	weapon_animation_player.current_animation = equipped_weapon_data.idle_animation
	weapon_animation_player.animation_finished.connect(on_animation_finished)
	weapon_hitbox.damage = equipped_weapon_data.damage

#call this in _physics_process function in child classes
func _physics_process(delta : float):
	#look into the other "action pressed" methods if this doesnt feel right
	get_animation_specifics()
	if Input.is_action_pressed("attack", false) && can_attack:
		is_attacking = true
		can_attack = false
		attack_cooldown_timer.start()
		weapon_hitbox.monitoring = true
		weapon_hitbox.monitorable = true
		weapon_animation_player.current_animation = equipped_weapon_data.attack_animation
	elif !is_attacking:
		weapon_animation_player.current_animation = equipped_weapon_data.idle_animation

func on_animation_finished() -> void:
	if weapon_animation_player.current_animation == equipped_weapon_data.attack_animation:
		weapon_hitbox.monitoring = false
		weapon_hitbox.monitorable = false
		is_attacking = false

func get_animation_specifics():
	var mouse_position = get_global_mouse_position()
	# Calculate the direction vector from the player to the mouse
	var direction = (mouse_position - player_object.position).normalized()
	var angle = direction.angle()
	
	#make the sword look at the mouse position
	weapon_sprite.look_at(get_global_mouse_position())
	weapon_hitbox.look_at(get_global_mouse_position())
	weapon_sprite.rotate(PI/2)
	weapon_hitbox.rotate(PI/2)
	
	# Calculate the new position of the sword based on the angle
	weapon_sprite.position = Vector2(cos(angle) * equipped_weapon_data.weapon_distance_x, sin(angle) * equipped_weapon_data.weapon_distance_y)
	weapon_hitbox.position = Vector2(cos(angle) * equipped_weapon_data.weapon_distance_x, sin(angle) * equipped_weapon_data.weapon_distance_y)

func _on_weapon_equipped(weapon : WeaponResource) -> void:
	_load_weapon(weapon) # Replace with function body.
