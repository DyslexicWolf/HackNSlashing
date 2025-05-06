extends Node2D

@onready var sword_animated_sprite = $AnimatedSprite2D
@onready var attack_cooldown_timer: Timer = null

# Width of the oval
var sword_distance_x: int = 24
# Height of the oval
var sword_distance_y: int = 30
var attack_cooldown: float = 1.5
var is_attacking: bool = false : set = set_is_attacking, get = get_is_attacking
var can_attack: bool = true : set = set_can_attack, get = get_can_attack

func set_is_attacking(value : bool):
	is_attacking = value

func get_is_attacking() -> bool:
	return is_attacking

func set_can_attack(value : bool):
	can_attack = value

func get_can_attack() -> bool:
	return can_attack

func _ready() -> void:
	attack_cooldown_timer = Timer.new()
	add_child(attack_cooldown_timer)
	attack_cooldown_timer.one_shot = true
	attack_cooldown_timer.wait_time = attack_cooldown
	attack_cooldown_timer.timeout.connect(set_can_attack.bind(true))
	sword_animated_sprite.animation_finished.connect(on_animation_finished)

func _process(delta):
	#look into the other "action pressed" methods if this doesnt feel right
	get_animation_specifics()
	if Input.is_action_pressed("attack", false) && can_attack:
		is_attacking = true
		can_attack = false
		attack_cooldown_timer.start()
		sword_animated_sprite.play("attack_vertical")
	elif !is_attacking:
		sword_animated_sprite.play("idle_vertical")

func on_animation_finished() -> void:
	if sword_animated_sprite.animation == "attack_vertical":
		is_attacking = false

func get_animation_specifics():
	var mouse_position = get_global_mouse_position()
	# Calculate the direction vector from the player to the mouse
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()
	
	#make the sword look at the mouse position
	sword_animated_sprite.look_at(get_global_mouse_position())
	sword_animated_sprite.rotate(PI/2)
	# Calculate the new position of the sword based on the angle
	sword_animated_sprite.position = Vector2(cos(angle) * sword_distance_x, sin(angle) * sword_distance_y)
