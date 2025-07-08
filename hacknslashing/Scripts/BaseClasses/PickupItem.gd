extends Node2D
class_name PickupItem
@export var item_resource : ItemResource
var pickup_sprite : Sprite2D
var pickup_text : Label

func _ready() -> void:
	pickup_sprite = $Sprite2D
	pickup_text = $PickupText

func send_item_data() -> ItemResource:
	return item_resource

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PickupManager":
		pickup_text.visible = true

func _on_area_exited(_area: Area2D) -> void:
	pickup_text.visible = false
