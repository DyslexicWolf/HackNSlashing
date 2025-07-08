extends Area2D
class_name HurtBox

signal received_damage(damage: int, damage_type: int)

func take_damage(damage: int, damage_type: int) -> void:
	#this function can be overridden by subclasses to handle damage differently
	received_damage.emit(damage, damage_type)
	print(get_parent().name + " received " + str(damage) + " damage of type " + str(damage_type))
	#can add extra functionality here for example: for sound, animation, UI, ...
