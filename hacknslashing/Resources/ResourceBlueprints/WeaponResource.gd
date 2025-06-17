extends Resource
class_name WeaponResource

@export var name : String
@export var weapon_distance_x : int
@export var weapon_distance_y : int
@export var attack_cooldown : float
@export var idle_animation : String
@export var attack_animation : String
@export var idle_animation_speed : float
@export var attack_animation_speed : float
@export var weapon_texture : Texture2D
@export var damage : int

#call this like you would call a function where you have a weapon resource variable
func example_method():
	print("example method yey")
