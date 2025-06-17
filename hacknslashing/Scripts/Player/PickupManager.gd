extends Node2D

var pickup_item: PickupResource
var parent
var can_pickup : bool = false
signal picked_up_weapon(weapon : WeaponResource)

#example of other signals we will need
#signal picked_up_charm

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pickup") && can_pickup : 
		picked_up_weapon.emit(pickup_item.weapon_resource)
		parent.queue_free()


func _on_pickup_hit_box_area_entered(area: Area2D) -> void:
	parent = area.get_parent()
	pickup_item = parent.send_item_data()
	can_pickup = true


func _on_pickup_hit_box_area_exited(area: Area2D) -> void:
	can_pickup = false
