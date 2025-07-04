extends HurtBox

func _ready() -> void:
	super.preload_variables()


func _physics_process(delta: float) -> void:
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area is HitBox:
			var parent_node = area.get_parent()
			if parent_node.name == "Player":
				var weapon_manager = parent_node.find_child("WeaponManager")
				if weapon_manager.is_attacking:
					print("Player is attacking")
					if not _damage_cooldowns.has(area):
						_damage_cooldowns[area] = 0.0
					_damage_cooldowns[area] -= delta
					if _damage_cooldowns[area] <= 0.0:
						received_damage.emit(area.damage, area.damage_type)
						_damage_cooldowns[area] = 1.0  # 1 second cooldown
