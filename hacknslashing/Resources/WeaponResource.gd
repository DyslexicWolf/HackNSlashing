extends Resource
class_name WeaponResource

@export var name : String
@export var weapon_distance_x : int
@export var weapon_distance_y : int
@export var attack_cooldown : float
@export var idle_animation : String
@export var attack_animation : String

#call this like you would call a function where you have a weapon resource variable
func example_method():
	print("example method yey")
