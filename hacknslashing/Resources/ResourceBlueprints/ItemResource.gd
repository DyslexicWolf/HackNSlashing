extends Resource
class_name ItemResource

enum Type {SCROLL, WEAPON, ARMOR}

@export var name : String
@export var type : Type
@export var ui_texture : Texture2D
@export_multiline var description : String
var pickup_scene_path : String = "res://Scenes/{name}_Pickup.tscn"
