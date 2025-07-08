class_name Weapon
extends Node2D

#set these variables in the init function in the child class
@export var equipped_weapon_data : WeaponResource
@onready var weapon_sprite = $"../WeaponSprite"
var weapon_animation_player = null
var weapon_hitbox = null
var player_object = null

var is_attacking: bool = false : set = set_is_attacking, get = get_is_attacking
var can_attack: bool = true : set = set_can_attack, get = get_can_attack
var calculated_physical_damage: int
var calculated_elemental_damage: int
var calculated_crit_chance: int
#has to be a float for accuracy, otherwise it auto rounds to whole numbers
var calculated_attack_animation_speed: float

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
	weapon_animation_player = $"../WeaponAnimationPlayer"
	weapon_hitbox = $"../WeaponHitBox"
	weapon_hitbox.monitoring = true
	weapon_hitbox.monitorable = true
	# weapon_hitbox.get_node("CollisionPolygon2D").disabled = false
	_load_weapon(equipped_weapon_data)

func _load_weapon(new_weapon_data : WeaponResource):
	equipped_weapon_data = new_weapon_data
	weapon_sprite.texture = equipped_weapon_data.animation_texture
	weapon_animation_player.play(equipped_weapon_data.idle_animation, -1, equipped_weapon_data.idle_animation_speed, false)
	if weapon_animation_player.animation_finished.is_connected(on_animation_finished) :
		weapon_animation_player.animation_finished.disconnect(on_animation_finished)
		weapon_animation_player.animation_finished.connect(on_animation_finished)
	else :
		weapon_animation_player.animation_finished.connect(on_animation_finished)
	#assign a temp value, this will be overwritten once the statmanager signals trigger
	weapon_hitbox.damage = calculated_physical_damage
	weapon_hitbox.elemental_damage = calculated_elemental_damage
	weapon_hitbox.damage_type = equipped_weapon_data.damage_type

#call this in _physics_process function in child classes
func _physics_process(_delta : float):
	get_animation_specifics()
	if Input.is_action_pressed("attack", false) and can_attack and !is_attacking:
		is_attacking = true
		can_attack = false
		calculate_crit()
		weapon_animation_player.play(equipped_weapon_data.attack_animation, -1, calculated_attack_animation_speed, false)
	elif !is_attacking:
		weapon_animation_player.play(equipped_weapon_data.idle_animation, -1, equipped_weapon_data.idle_animation_speed, false)
	

func on_animation_finished(animation_name : String):
	if animation_name == equipped_weapon_data.attack_animation:
		is_attacking = false
		can_attack = true
		
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

func _on_weapon_hit_box_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		var hurtbox = area as HurtBox
		#possible additional checks here if we come across problems,  "and hurtbox.is_player == false"
		if hurtbox != null:
			hurtbox.take_damage(calculated_physical_damage, weapon_hitbox.damage_type)

			#emit a signal for the player to know that it hit an enemy (example) for sound etc
			# player_object.weapon_hit_enemy.emit(hurtbox, calculated_physical_damage, weapon_hitbox.damage_type)

func calculate_crit() -> void:
	pass

func _on_weapon_equipped(weapon : WeaponResource) -> void:
	_load_weapon(weapon)

func _on_picked_up_weapon(weapon: WeaponResource) -> void:
	_load_weapon(weapon)

func _on_strength_changed(new_value: int) -> void:
	#temp calculation with testing values
	var scaling_factor := 0.05
	calculated_physical_damage = int(equipped_weapon_data.base_damage * (1 + new_value * scaling_factor))
	if weapon_hitbox != null:
		weapon_hitbox.damage = calculated_physical_damage

func _on_intelligence_changed(new_value: int) -> void:
	#temp calculation with testing values
	var scaling_factor := 0.07
	calculated_elemental_damage = int(equipped_weapon_data.base_elemental_damage * (1 + new_value * scaling_factor))
	if weapon_hitbox != null:
		weapon_hitbox.elemental_damage = calculated_elemental_damage

func _on_crit_chance_changed(new_value: int) -> void:
	#temp calculation with testing values
	var base_value := equipped_weapon_data.base_crit_chance
	var scaling := 0.0025
	calculated_crit_chance = int(base_value + new_value * scaling)

func _on_attack_speed_changed(new_value: int) -> void:
	#temp calculation with testing values
	var base_attack_rate := equipped_weapon_data.attack_animation_speed
	var scaling := 0.01
	calculated_attack_animation_speed = base_attack_rate * (1 + new_value * scaling)
