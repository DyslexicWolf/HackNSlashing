extends CanvasLayer
class_name InventoryManager

signal weapon_equipped(weapon: WeaponResource, slot_index: int)
signal weapon_unequipped(weapon: WeaponResource, slot_index: int)
var inventory_size = 8
var inventory_gridpanel : GridContainer
var weapon_slots: Array = [null, null]
var active_weapon_index: int = 0
var temp_items_load_fortesting = [
	"res://Resources/SpearResource.tres",
]

func _ready():
	inventory_gridpanel = $Inventory
	for i in inventory_size:
		var slot := InventorySlot.new()
		slot.initialize(ItemResource.Type.WEAPON, Vector2(64, 64))
		inventory_gridpanel.add_child(slot)
		slot.connect("item_unequipped", _on_item_unequipped)
	
	for i in temp_items_load_fortesting.size():
		var item_resource = load(temp_items_load_fortesting[i])
		var item := InventoryItem.new()
		item.initialize(item_resource)
		inventory_gridpanel.get_child(i).add_child(item)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		self.visible = true
	if Input.is_action_just_pressed("close_inventory"):
		self.visible = false

func _on_item_equipped(item: InventoryItem, slot_index: int) -> void:
	if item.item_data is WeaponResource:
		#this depends on how many weapon slots we have, if we have 2 weapon slots, we can only unequip from slot 0 or 1
		if slot_index > 1:
			slot_index = 0
		weapon_slots[slot_index] = item
		weapon_equipped.emit(item.item_data, slot_index)

func _on_item_unequipped(item: InventoryItem, slot_index: int) -> void:
	if item.item_data is WeaponResource:
		#this depends on how many weapon slots we have, if we have 2 weapon slots, we can only unequip from slot 0 or 1
		if slot_index > 1:
			slot_index = 0
		weapon_slots[slot_index] = null
		weapon_unequipped.emit(slot_index)

func _on_picked_up_weapon(weapon: WeaponResource) -> void:
	# Check if there is an empty slot in the inventory
	for i in range(inventory_gridpanel.get_child_count()):
		var slot = inventory_gridpanel.get_child(i)
		if slot.get_child_count() == 0:
			var item := InventoryItem.new()
			item.initialize(weapon)
			slot.add_child(item)
			return
	
	var new_item := InventoryItem.new()
	new_item.initialize(weapon)
	inventory_gridpanel.get_child(0).add_child(new_item)
	weapon_slots[0] = new_item

func has_empty_slot() -> bool:
	for i in range(inventory_gridpanel.get_child_count()):
		var slot = inventory_gridpanel.get_child(i)
		if slot.get_child_count() == 0:
			return true
	return false
