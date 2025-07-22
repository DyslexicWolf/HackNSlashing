extends Node2D
class_name PickupItem

@export var item_resource : ItemResource
var pickup_text : Label
var pickup_area : Area2D

func _ready() -> void:
	pickup_text = $PickupText
	pickup_area = $PickupArea
	pickup_area.connect("area_entered", _on_area_entered)
	pickup_area.connect("area_exited", _on_area_exited)

func send_item_data() -> ItemResource:
	return item_resource

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PickupManager":
		pickup_text.visible = true

func _on_area_exited(_area: Area2D) -> void:
	pickup_text.visible = false
