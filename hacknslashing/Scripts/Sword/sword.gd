extends Weapon

func _init() -> void:
	weapon_distance_x = 24
	weapon_distance_y = 30
	attack_cooldown = 0.5
	
func _ready() -> void:
	weapon_animated_sprite = $AnimatedSprite2D
	weapon_hitbox = $HitBox
	super.preload_variables()

func _physics_process(delta: float) -> void:
	super.weapon_physics()
