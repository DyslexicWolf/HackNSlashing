extends HurtBox

func _ready() -> void:
	health = $"../HealthManager"
	super.preload_variables()

#we take area2d as argument so we stay general and the doesnt error, after we check if it is a hitbox
func _on_area_entered(hitbox: Area2D) -> void:
	if  hitbox is HitBox:
		print(self.name + " got hit")
		received_damage.emit(hitbox.damage, hitbox.damage_type)
