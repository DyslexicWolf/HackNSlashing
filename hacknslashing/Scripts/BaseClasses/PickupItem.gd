extends Node2D

@export var pickResource : PickupResource
var pickup_sprite : Sprite2D
var pickup_text : Label

func _ready() -> void:
	pickup_sprite = $Sprite2D
	pickup_text = $PickupText

func send_item_data() -> PickupResource:
	return pickResource


func _on_area_entered(area: Area2D) -> void:
	pickup_text.visible = true


func _on_area_exited(area: Area2D) -> void:
	pickup_text.visible = false
