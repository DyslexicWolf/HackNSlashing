extends PanelContainer
class_name InventorySlot

@export var type : ItemResource.Type
var dropped_item : InventoryItem = null
var previous_item : InventoryItem = null

signal item_unequipped(item : InventoryItem)
signal item_equipped(item : InventoryItem)


func initialize(t: ItemResource.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms

#this function checks if what we are dragging can be dropped into the slot we are hovering
#data is the item that we are dragging around with our mouse
func _can_drop_data(at_position: Vector2, data: Variant):
	if data is InventoryItem:
		var item_type = data.item_data.type
		if item_type != type:
			return false
		
		elif get_child_count() == 0:
			return true
		else:
			if type == data.get_parent().type:
				return true
		return get_child(0).data.type == data.item_data.type
	else:
		return data.item_data.type == type
	return false

#this function drops the item into the inventory slot after _can_drop_data has been called and returned true
func _drop_data(at_position: Vector2, data: Variant):
	# If there's already an item, handle swapping
	if get_child_count() > 0:
		var existing_item := get_child(0)
		if existing_item == dropped_item:
			return
		
		previous_item = existing_item
		existing_item.reparent(dropped_item.get_parent())
		item_unequipped.emit(previous_item)

	# Reparent the dropped item into the slot
	dropped_item.reparent(self)
	item_equipped.emit(dropped_item)
