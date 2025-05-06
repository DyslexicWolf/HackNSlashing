extends CharacterBody2D

const SPEED = 130.0
var direction
var isAttacking: bool = false
@onready var player_animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float):
	#read input
	get_input()
	#changed animation if needed
	change_animation()
	#move character using buildin function
	move_and_slide()

func get_input():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

func change_animation():
	#y-axis is flipped in godot!!!
	if direction.y < 0:
		player_animated_sprite.play("run_back")
	elif direction.y > 0:
		player_animated_sprite.play("run_front")
	elif direction.x > 0:
		player_animated_sprite.flip_h = false
		player_animated_sprite.play("idle_front")
	elif direction.x < 0:
		player_animated_sprite.flip_h = true
		player_animated_sprite.play("idle_front")
	else:
		player_animated_sprite.play("idle_front")
func attack():
	pass

func _on_health_changed(diff: int) -> void:
	print("player took damage")


func _on_health_depleted() -> void:
	print("player died")
	queue_free()
