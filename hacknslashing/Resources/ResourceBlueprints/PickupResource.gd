extends Resource
class_name PickupResource

@export var name : String
@export var texture : Texture2D
@export var weapon_resource : WeaponResource

#call this like you would call a function where you have a weapon resource variable
func example_method():
	print("example method yey")
