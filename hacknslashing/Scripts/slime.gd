extends RigidBody2D

#connect this function to the health script signal
func _on_health_depleted() -> void:
	queue_free()


func _on_health_changed(diff: int) -> void:
	print("health changed")
