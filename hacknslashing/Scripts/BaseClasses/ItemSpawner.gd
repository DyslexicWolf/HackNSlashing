extends Node2D
class_name ItemSpawner

var current_dungeon_level:  = ""
var current_item_pool : ItemPool = null
var test_string_dungeon_level = "OvergrownMantel_ItemPool"
var has_spawned = false

func _ready() -> void:
	#for testing
	_on_dungeon_level_changed(test_string_dungeon_level)

func _on_dungeon_level_changed(new_level: String) -> void:
	if new_level != current_dungeon_level:
		current_dungeon_level = new_level
		current_item_pool = load("res://Resources/OvergrownMantel_ItemPool.tres")
		print("Dungeon level changed to: ", current_dungeon_level)

func _process(_delta: float) -> void:
	if !has_spawned and current_item_pool != null:
		print("spawned item")
		has_spawned = true
		_on_spawn_item(Vector2(50, 0))

func _on_spawn_item(enemy_death_position: Vector2) -> void:
	var item_scene = current_item_pool.get_random_item()
	if item_scene:
		var item_instance = item_scene.instantiate()
		#set the position of the item, this is based on where the enemy died
		item_instance.position = enemy_death_position
		add_child(item_instance)
	else:
		print("No item returned from item pool.")

func _on_item_dropped_from_inventory(data : InventoryItem) -> void:
	var item_to_spawn = load(data.item_data.pickup_scene_path.format({"name": data.item_data.name}))
	var item_instance = item_to_spawn.instantiate()
	item_instance.position = get_global_mouse_position()
	add_child(item_instance)
