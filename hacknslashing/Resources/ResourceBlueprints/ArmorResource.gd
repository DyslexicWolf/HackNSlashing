extends ItemResource
class_name ArmorResource

enum ArmorType {HELMET, BOOTS, CHESTPLATE, GLOVES}

@export var armor_type : ArmorType

#call this like you would call a function where you have a weapon resource variable
func example_method():
	print("example method yey")
