extends Resource
class_name ItemPool

@export var item_pool : Array[PackedScene] = []

func get_random_item() -> PackedScene:
	if item_pool.size() == 0:
		print("item pool is 0")
		return null
	var random_index = randi() % item_pool.size()
	return item_pool[random_index]
