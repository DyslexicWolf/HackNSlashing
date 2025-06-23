extends TextureRect
class_name InventoryItem

@export var data : ItemResource

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	if data != null:
		texture = data.inventory_texture
		tooltip_text = "%s\n%s" % [data.name, data.description]

func initialize(d: ItemResource) -> void:
	data = d

func _get_drag_data(at_position: Vector2):
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_position: Vector2):
	var t := TextureRect.new()
	t.texture = data.inventory_texture
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_position)
	
	var c := Control.new()
	c.add_child(t)
	return c
