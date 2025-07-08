extends CanvasLayer

var inventory_size = 8
var inventory_gridpanel : GridContainer
var items_load = [
	"res://Resources/SpearResource.tres",
	"res://Resources/SwordResource.tres"
]

func _ready():
	inventory_gridpanel = $Inventory
	for i in inventory_size:
		var slot := InventorySlot.new()
		slot.initialize(ItemResource.Type.WEAPON, Vector2(64, 64))
		inventory_gridpanel.add_child(slot)
	
	for i in items_load.size():
		var item_resource = load(items_load[i])
		print("Loaded resource:", item_resource)
		var item := InventoryItem.new()
		item.initialize(load(items_load[i]))
		inventory_gridpanel.get_child(i).add_child(item)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory_menu"):
		self.visible = !self.visible
