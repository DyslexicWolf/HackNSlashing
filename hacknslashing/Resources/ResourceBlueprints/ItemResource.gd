extends Resource
class_name ItemResource

enum Type {CHARM, WEAPON, ARMOR}

@export var type : Type
@export var name : String
@export var inventory_texture : Texture2D
@export_multiline var description : String
