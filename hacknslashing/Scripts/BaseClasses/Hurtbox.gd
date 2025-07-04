extends Area2D
class_name HurtBox

signal received_damage(damage: int, damage_type: int)

var _damage_cooldowns := {}

func preload_variables() -> void:
	set_process(true)

func _physics_process(delta: float) -> void:
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area is HitBox:
			print(area.name)
			if not _damage_cooldowns.has(area):
				_damage_cooldowns[area] = 0.0
			_damage_cooldowns[area] -= delta
			if _damage_cooldowns[area] <= 0.0:
				received_damage.emit(area.damage, area.damage_type)
				_damage_cooldowns[area] = 1.0  # 1 second cooldown

	# Clean up cooldowns for hitboxes that are no longer overlapping
	for area in _damage_cooldowns.keys():
		if area not in overlapping:
			_damage_cooldowns.erase(area)
