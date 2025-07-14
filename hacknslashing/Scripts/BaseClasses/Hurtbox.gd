extends Area2D
class_name HurtBox

signal received_damage(damage: int, damage_type: int)
@export var is_player: bool = false

func take_damage(damage: int, damage_type: int) -> void:
	#this function can be overridden by subclasses to handle damage differently
	received_damage.emit(damage, damage_type)
	#can add extra functionality here for example: for sound, animation, UI, ...
