extends Area2D
class_name HurtBox

signal received_damage(damage: int, damage_type: int)
#var hurtbox : Area2D = null
#var already_hit_boxes : Array = []

#connect the onareaentered fucntion to the area_entered signal (otherwise you would have to do this manually for every instance of the hurtboxes you have
#call in _ready function in child classes
func preload_variables() -> void:
	connect("area_entered", _on_area_entered)

#we take area2d as argument so we stay general and the doesnt error, after we check if it is a hitbox
func _on_area_entered(hitbox: Area2D) -> void:
	print("in area entered")
	if  hitbox is HitBox:
		print(self.name + " got hit")
		received_damage.emit(hitbox.damage, hitbox.damage_type)

#func overlapping_hitboxes() -> void:
	#for area in hurtbox.get_overlapping_areas():
		#if area is HitBox and !already_hit_boxes.has(area):
			#print(self.name + " got hit")
			#health.health -= area.damage
			#received_damage.emit(area.damage)
			#already_hit_boxes.append(area)
