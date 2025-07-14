extends RigidBody2D

#connect this function to the health script signal
func _on_health_depleted() -> void:
	queue_free()

func _on_health_changed(_diff: int) -> void:
	#can be used to play hurt animation or sound for the slime
	print("slime health changed")
