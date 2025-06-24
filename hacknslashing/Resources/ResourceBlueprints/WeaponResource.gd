extends ItemResource
class_name WeaponResource

@export var weapon_distance_x : int
@export var weapon_distance_y : int
@export var idle_animation : String
@export var attack_animation : String
@export var animation_texture : Texture2D
@export var idle_animation_speed : float
@export var attack_animation_speed : float
@export var base_attack_speed : float
@export var base_damage : int
@export var base_elemental_damage : int
@export var base_crit_chance : float

#call this like you would call a function where you have a weapon resource variable
func example_method():
	print("example method yey")
