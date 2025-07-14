extends PanelContainer
class_name InventorySlot

@export var type : ItemResource.Type
var previous_item : InventoryItem = null
signal item_unequipped(item : InventoryItem, slot_index : int)

func initialize(t: ItemResource.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms

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
		
		if get_child_count() > 0:
			print("unequipped 2")
			var existing_item := get_child(0)
			previous_item = existing_item
			#Move the existing item (in the slot) to the slot of the item you are swapping it with
			var new_slot = data.get_parent()
			existing_item.get_parent().remove_child(existing_item)
			if new_slot:
				new_slot.get_parent().add_child(existing_item)
				if new_slot == EquipementSlot:
					item_unequipped.emit(previous_item, new_slot.slot_index)
		
		if data.get_parent() is EquipementSlot:
			item_unequipped.emit(data, data.get_parent().slot_index)
		
		#Move the dragged item into this slot
		data.get_parent().remove_child(data)
		add_child(data)
		
