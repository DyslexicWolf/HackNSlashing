extends Area2D

@onready var inventory_manager = $"../InventoryManager"
var pickup_items: Array[PickupItem] = []

signal picked_up_weapon(weapon : WeaponResource)

signal picked_up_scroll(scroll : ScrollResource)

signal picked_up_armor(armor : ArmorResource)


func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_area_entered(area):
	var parent = area.get_parent()
	if parent is PickupItem:
		if parent not in pickup_items:
			pickup_items.append(parent)

func _on_area_exited(area):
	var parent = area.get_parent()
	if parent is PickupItem:
		if parent in pickup_items:
			pickup_items.erase(parent)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pickup"):
		if pickup_items.size() != 0:
			var first_pickup = pickup_items[0]
			var item = first_pickup.item_resource
			if inventory_manager.has_empty_slot():
				if item is WeaponResource:
					picked_up_weapon.emit(item as WeaponResource)
				elif item is ScrollResource:
					picked_up_scroll.emit(item as ScrollResource)
				elif item is ArmorResource:
					picked_up_armor.emit(item as ArmorResource)
					pickup_items.erase(first_pickup)
				first_pickup.queue_free()
			else:
				#IMPLEMENT THIS LOGIC, THE ITEM SHOULDNT BE PICKED UP OR DELETED IF THERE IS NO EMPTY SLOT
				#!!!!!!
				print("No empty inventory slot!")
