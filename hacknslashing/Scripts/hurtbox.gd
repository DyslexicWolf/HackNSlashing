class_name HurtBox
extends Area2D

signal received_damage(damage: int)

@export var health: Health

#connect the onareaentered fucntion to the area_entered signal (otherwise you would have to do this manually for every instance of the hurtboxes you have
func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		print("in on area entered")
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
