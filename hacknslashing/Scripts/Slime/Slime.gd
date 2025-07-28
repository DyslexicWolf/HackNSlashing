extends RigidBody2D

var direction = Vector2()
var player
var distance
var follow = false
var speed
var is_Dying = false
var agro_range
var attack_range
var damage
var damage_type
@onready var slime_sprite = self.get_node("Sprite2D")
@onready var animated_sprite = get_node("AnimationPlayer")
var current_animation = "" #tracks current animation

func _ready() -> void:
	speed = 30
	agro_range = 200
	attack_range = 20
	damage = 1
	player = get_tree().get_root().get_node("Game/Player")

func _process(delta: float) -> void:
	direction = (player.position - position)
	var raycast = $RayCast2D
	raycast.target_position = direction.normalized() * agro_range
	raycast.force_raycast_update()
	
	var player_collision = raycast.is_colliding() and raycast.get_collider() == player
	distance = direction.length()
	
	if player_collision and distance <= agro_range:
		follow = true
	else:
		follow = false
	
	if follow and current_animation != "attack":
		animated_sprite.play("idle")
		current_animation = "idle"
		position += direction.normalized() * speed * delta
	
	slime_sprite.set_flip_h(direction.x > 0)

func _attack(area):
	if distance <= attack_range and area.get_name() == "player" and current_animation != "attack":
		animated_sprite.play("attack") #starts the attack animation
		current_animation = "attack"

func _on_enemy_area_entered(area):
	if area is HurtBox:
		var hurtbox = area as HurtBox
		if hurtbox != null and hurtbox.is_player == true:
			hurtbox.take_damage(damage, damage_type)

func _on_animation_finished():
	if animated_sprite.animation == "attack":
		animated_sprite.play("idle")
		current_animation = "idle"
	if current_animation == "death":
		queue_free()

#connect this function to the health script signal
func _on_health_depleted() -> void:
	if not is_Dying:
		is_Dying = true
		animated_sprite.play("death")
		current_animation = "death"

func _on_health_changed(_diff: int) -> void:
	#can be used to play hurt animation or sound for the slime
	print("slime health changed")
