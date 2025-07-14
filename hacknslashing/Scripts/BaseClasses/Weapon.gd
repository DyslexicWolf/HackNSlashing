class_name Weapon
extends Node2D

signal weapon_loaded()

var weapon_datas: Array[WeaponResource] = [null, null]
var active_weapon_index: int = 0
var current_data: WeaponResource = null

@onready var weapon_sprite = $"../WeaponSprite"
var weapon_animation_player = null
var weapon_hitbox = null
var player_object = null

var is_attacking: bool = false : set = set_is_attacking, get = get_is_attacking
var can_attack: bool = true : set = set_can_attack, get = get_can_attack
var calculated_physical_damage: int
var calculated_elemental_damage: int
var calculated_crit_chance: int
var calculated_attack_animation_speed: float

func set_is_attacking(value : bool):
	is_attacking = value

func get_is_attacking() -> bool:
	return is_attacking

func set_can_attack(value : bool):
	can_attack = value

func get_can_attack() -> bool:
	return can_attack

func _ready() -> void:
	player_object = get_parent()
	weapon_animation_player = $"../WeaponAnimationPlayer"
	weapon_hitbox = $"../WeaponHitBox"

func _load_weapon(index : int):
	var new_weapon_data = weapon_datas[index]
	if new_weapon_data == null:
		weapon_sprite.texture = null
		weapon_animation_player.stop()
		weapon_hitbox.damage = 0
		weapon_hitbox.elemental_damage = 0
		return
	
	current_data = new_weapon_data
	weapon_loaded.emit()
	weapon_sprite.texture = new_weapon_data.animation_texture
	weapon_animation_player.play(new_weapon_data.idle_animation, -1, new_weapon_data.idle_animation_speed, false)
	can_attack = true
	is_attacking = false
	
func _physics_process(_delta : float):
	get_animation_specifics()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("attack", false) and can_attack and !is_attacking and current_data != null:
		is_attacking = true
		can_attack = false
		calculate_crit()
		weapon_animation_player.play(current_data.attack_animation, -1, calculated_attack_animation_speed, false)
	elif !is_attacking and current_data != null:
		weapon_animation_player.play(current_data.idle_animation, -1, current_data.idle_animation_speed, false)
	
	if event.is_action_pressed("swap_weapon_up"):
		_swap_weapon(1)
	elif event.is_action_pressed("swap_weapon_down"):
		_swap_weapon(-1)

func _swap_weapon(direction: int):
	var next_index = (active_weapon_index + direction) % 2
	if next_index < 0:
		next_index = 1
	if weapon_datas[next_index] != null:
		active_weapon_index = next_index
		print("swap weapon")
		_load_weapon(active_weapon_index)
		#possibly emit a signal for the player to know that the weapon has been swapped
		#ex. player_object.weapon_swapped.emit(weapon_datas[active_weapon_index], active_weapon_index)

func _on_animation_finished(animation_name : String):
	if current_data != null and animation_name == current_data.attack_animation:
		is_attacking = false
		can_attack = true
		
func get_animation_specifics():
	if current_data == null:
		return
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - player_object.position).normalized()
	var angle = direction.angle()
	
	weapon_sprite.look_at(get_global_mouse_position())
	weapon_hitbox.look_at(get_global_mouse_position())
	weapon_sprite.rotate(PI/2)
	weapon_hitbox.rotate(PI/2)
	
	weapon_sprite.position = Vector2(cos(angle) * current_data.weapon_distance_x, sin(angle) * current_data.weapon_distance_y)
	weapon_hitbox.position = Vector2(cos(angle) * current_data.weapon_distance_x, sin(angle) * current_data.weapon_distance_y)

func _on_weapon_hit_box_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		var hurtbox = area as HurtBox
		if hurtbox != null and hurtbox.is_player == false:
			hurtbox.take_damage(calculated_physical_damage, weapon_hitbox.damage_type)
			#emit a signal for the player to know that it hit an enemy (example) for sound etc
			# player_object.weapon_hit_enemy.emit(hurtbox, calculated_physical_damage, weapon_hitbox.damage_type)

func calculate_crit() -> void:
	pass

func _on_weapon_equipped(weapon : WeaponResource, slot_index: int) -> void:
	print("Equipping weapon:", weapon.name, " at slot index:", slot_index)
	weapon_datas[slot_index] = weapon
	active_weapon_index = slot_index
	_load_weapon(active_weapon_index)
		#possibly emit a signal to the player that the weapon has been equipped
		#ex. player_object.weapon_loaded.emit(weapon, slot_index)

func _on_weapon_unequipped(slot_index: int) -> void:
	print("Unequipping weapon at slot index:", slot_index)
	weapon_datas[slot_index] = null
	if active_weapon_index == slot_index:
		if slot_index == 1:
			active_weapon_index = 0
		else:
			active_weapon_index = 1
		_load_weapon(active_weapon_index)
		#emit a signal to the player that the weapon has been unequipped
		#ex. player_object.weapon_unequipped.emit(weapon, slot_index)
		

func _on_strength_changed(new_value: int) -> void:
	#temp calculation/values
	if current_data == null:
		return
	var scaling_factor := 0.05
	calculated_physical_damage = int(current_data.base_damage * (1 + new_value * scaling_factor))
	if weapon_hitbox != null:
		weapon_hitbox.damage = calculated_physical_damage

func _on_intelligence_changed(new_value: int) -> void:
	#temp calculation/values
	if current_data == null:
		return
	var scaling_factor := 0.07
	calculated_elemental_damage = int(current_data.base_elemental_damage * (1 + new_value * scaling_factor))
	if weapon_hitbox != null:
		weapon_hitbox.elemental_damage = calculated_elemental_damage

func _on_crit_chance_changed(new_value: int) -> void:
	#temp calculation/values
	if current_data == null:
		return
	var base_value := current_data.base_crit_chance
	var scaling := 0.0025
	calculated_crit_chance = int(base_value + new_value * scaling)

func _on_attack_speed_changed(new_value: int) -> void:
	#temp calculation/values
	if current_data == null:
		return
	var base_attack_rate := current_data.attack_animation_speed
	var scaling := 0.01
	calculated_attack_animation_speed = base_attack_rate * (1 + new_value * scaling)
