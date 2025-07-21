extends InventorySlot
class_name EquipementSlot


@export var slot_index : int = -1
signal item_equipped(item : InventoryItem, slot_index : int)


# Checks if the dragged item can be dropped into this slot
func _can_drop_data(_at_position: Vector2, data: Variant):
	if data is InventoryItem:
		var item_type = data.item_data.type
		if item_type != type:
			return false
		elif get_child_count() == 0:
			return true
		else:
			if type == data.get_parent().type:
				return true
		return get_child(0).item_data.type == data.item_data.type
	return false


func _drop_data(_at_position: Vector2, data: Variant):
	if data is InventoryItem:
		if data.get_parent() == self:
			return

		#if there is an existing item switch it with the dragged item
		if get_child_count() > 0:
			var existing_item := get_child(0)
			previous_item = existing_item
			var old_slot = data.get_parent()
			existing_item.get_parent().remove_child(existing_item)

			if old_slot != null:
				old_slot.get_parent().add_child(existing_item)
				if old_slot is EquipementSlot:
					item_unequipped.emit(data, old_slot.slot_index)
		
		elif data.get_parent() is EquipementSlot:
			item_unequipped.emit(data, data.get_parent().slot_index)
		
		#Move the dragged item into this slot
		data.get_parent().remove_child(data)
		add_child(data)
		item_equipped.emit(data, slot_index)
