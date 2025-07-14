extends Node2D

@export var sword_pickup : ItemResource
var pickup_scene = preload("res://Scenes/PickupItem.tscn")

func _ready() -> void:
	var _inst_pickup_scene = pickup_scene.instantiate()
