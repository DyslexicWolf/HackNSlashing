extends CanvasLayer
class_name InventoryManager

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
	
	for i in temp_items_load_fortesting.size():
		var item_resource = load(temp_items_load_fortesting[i])
		print("Loaded resource:", item_resource)
		var item := InventoryItem.new()
		item.initialize(load(temp_items_load_fortesting[i]))
		inventory_gridpanel.get_child(i).add_child(item)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory_menu"):
		self.visible = !self.visible


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
	print("Picked up weapon:", weapon.name)


func has_empty_slot() -> bool:
	for i in range(inventory_gridpanel.get_child_count()):
		var slot = inventory_gridpanel.get_child(i)
		if slot.get_child_count() == 0:
			return true
	return false
