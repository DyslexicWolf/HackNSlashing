extends Node2D

signal weapon_equipped(WeaponResource)
@export var weaponpickuptest: WeaponResource

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pickup") : 
		weapon_equipped.emit(weaponpickuptest)
