extends HurtBox

func _ready() -> void:
	health = $"../Health_player"
	super.preload_variables()
