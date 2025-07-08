extends Resource
class_name PickupResource

@export var name : String
@export var texture : Texture2D
#change weaponresource to an item resource and adjust other functions that use this
#add a id/tag variable so that the pickupmanager knows what type of item this is
@export var weapon_resource : WeaponResource

#call this like you would call a function where you have a weapon resource variable
func example_method():
	print("example method yey")
