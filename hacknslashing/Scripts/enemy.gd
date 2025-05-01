extends RigidBody2D

class_name Enemy

var health :int = 10
var damage :int = 2

func _process(delta: float) -> void:
	pass
	
func _takeDamage(damageTaken):
	health =- damageTaken
	if health <= 0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	body._takeDamage(damage)
