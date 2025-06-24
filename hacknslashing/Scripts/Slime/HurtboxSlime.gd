extends HurtBox

func _ready() -> void:
	health = $"../HealthManager"
	super.preload_variables()
