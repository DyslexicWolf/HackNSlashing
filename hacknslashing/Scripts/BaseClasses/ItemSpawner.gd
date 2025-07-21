extends Node2D

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

func _process(delta: float) -> void:
	if !has_spawned and current_item_pool != null:
		_on_spawn_item()

func _on_spawn_item() -> void:
	current_item_pool.get_random_item()
