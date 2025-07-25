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
		var old_slot = data.get_parent()
		
		if self is EquipementSlot or old_slot is EquipementSlot or old_slot is InventorySlot:
			if old_slot == self:
				return
			
			#cant use old_slot here since we dont know what the current parent is of data
			if data.get_parent():
				data.get_parent().remove_child(data)
			
			#if there is an existing item switch it with the dragged item
			if get_child_count() > 0:
				var existing_item = get_child(0)
				remove_child(existing_item)
				old_slot.add_child(existing_item)
				
				if old_slot is EquipementSlot:
					item_unequipped.emit(existing_item, old_slot.slot_index)
			
			if old_slot is EquipementSlot:
				item_unequipped.emit(data, old_slot.slot_index)
			
			add_child(data)
			item_equipped.emit(data, slot_index)
