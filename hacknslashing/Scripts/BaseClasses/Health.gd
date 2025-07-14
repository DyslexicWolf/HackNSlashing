extends Node2D
class_name Health

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted

var max_health: int  : set = set_max_health, get = get_max_health
var health: int : set = set_health, get = get_health
var current_armor: int
enum DamageType {PHYSICAL, ELEMENTAL}

func set_max_health(value: int):
	#clampedvalue is 1 if you set maxhealth = 0 else it is the value provided
	var clamped_value = 1 if value <= 0 else value
	
	if clamped_value != max_health:
		var difference = clamped_value - max_health
		max_health = clamped_value
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health

func set_health(value: int):
	var clamped_value = clampi(value, 0, max_health)
	if clamped_value != health:
		var difference = clamped_value - health
		health = clamped_value
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()

func get_max_health() -> int:
	return max_health

func get_health() -> int:
	return health

func _on_received_damage(damage: int, damage_type: DamageType) -> void:
	#temp calculation/values
	if damage_type == DamageType.PHYSICAL:
		var mitigation := current_armor / (current_armor + 100.0)
		var reduced_damage := damage * (1 - mitigation)
		health -= int(reduced_damage)
	elif damage_type == DamageType.ELEMENTAL:
		#Elemental resistance can be added here if wanted
		health -= damage
