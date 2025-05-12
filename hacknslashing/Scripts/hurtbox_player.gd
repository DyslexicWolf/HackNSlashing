extends HurtBox

func _ready() -> void:
	health = $"../Health"
	super.preload_variables()
