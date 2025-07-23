extends Node2D
class_name PickupItem

@export var item_resource : ItemResource
var button_icon : TextureRect
var pickup_area : Area2D

func _ready() -> void:
	button_icon = $ButtonIcon
	pickup_area = $PickupArea
	pickup_area.connect("area_entered", _on_area_entered)
	pickup_area.connect("area_exited", _on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PickupManager":
		var pickup_event = get_first_input_event("pickup")
		if pickup_event:
			var icon = InputIcons.get_icon_for_event(pickup_event)
			if icon:
				button_icon.texture = icon
				button_icon.visible = true
			else:
				print("No icon found for event: ", pickup_event)

func _on_area_exited(_area: Area2D) -> void:
	button_icon.visible = false

func get_first_input_event(action_name: String) -> InputEvent:
	var events = InputMap.action_get_events(action_name)

	#can add logic here to see which control scheme the user is using, and then sending the right icon based on that
	if events.size() > 0:
		return events[0]
	else:
		print("No input events found for action: ", action_name)
		return null
