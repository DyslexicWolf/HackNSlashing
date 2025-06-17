extends HurtBox

func _ready() -> void:
	health = $"../HealthPlayer"
	super.preload_variables()
