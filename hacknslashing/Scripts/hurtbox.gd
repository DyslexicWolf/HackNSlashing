class_name HurtBox
extends Node2D

signal received_damage(damage: int)

var health = null

#connect the onareaentered fucntion to the area_entered signal (otherwise you would have to do this manually for every instance of the hurtboxes you have
#call in _ready function in child classes
func preload_variables() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		print(self.name + " got hit")
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
