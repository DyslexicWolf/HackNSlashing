extends PanelContainer
class_name InventorySlot

@export var type : ItemResource.Type

func initialize(t: ItemResource.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms


#this function checks if what we are dragging can be dropped into the slot we are hovering
#we should add extra logic to check if the inventoryslot at the position we are hovering is of the same type 
#as the item that we are holding, if so, it should return true
func _can_drop_data(at_position: Vector2, data: Variant):
	if data is InventoryItem:
		if type == ItemResource.Type.WEAPON:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
			return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	return false


#this function drops the item into the inventory slot after _can_drop_data has been called and returned true
#we should add logic here (probably signals) that processes the item, like stat changes, active weapons, etc
func _drop_data(at_position: Vector2, data: Variant):
	if get_child_count() > 0:
		var item := get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())
	data.reparent(self)
