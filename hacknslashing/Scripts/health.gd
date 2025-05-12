class_name Health
extends Node2D

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted

var max_health: int  : set = set_max_health, get = get_max_health
var health: int : set = set_health, get = get_health

func set_max_health(value: int):
	#clampedvalue is 1 if you set maxhealth = 0 else it is the value provided
	var clamped_value = 1 if value <= 0 else value
	
	if clamped_value != max_health:
		#calculate the maxhealthchange
		var difference = clamped_value - max_health
		max_health = clamped_value
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health

func get_max_health() -> int:
	return max_health


func set_health(value: int):
	#return (do nothing) if you value is lower than health (because we will have a takedamage func for that
	#or if immortality is true
	if value < health:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	if clamped_value != health:
		#calculate the healthchange
		var difference = clamped_value - health
		health = clamped_value
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()

func get_health() -> int:
	return health
