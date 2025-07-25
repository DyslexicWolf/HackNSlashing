extends Control

signal item_dropped(item: InventoryItem)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is InventoryItem

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data is InventoryItem:
		if data.get_parent():
			data.get_parent().remove_child(data)

		item_dropped.emit(data)
