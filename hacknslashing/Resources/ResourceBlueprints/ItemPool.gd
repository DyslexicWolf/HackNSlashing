extends Resource
class_name ItemPool

@export var item_pool : Array[ItemResource] = []

func get_random_item() -> ItemResource:
    if item_pool.size() == 0:
        return null
    var random_index = randi() % item_pool.size()
    return item_pool[random_index]