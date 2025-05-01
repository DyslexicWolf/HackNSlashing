extends CharacterBody2D

const SPEED = 130.0
var direction
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float):
	#read input
	get_input()
	#changed animation if needed
	change_animation()
	#move character using buildin function
	move_and_slide()

func get_input():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print(direction)
	velocity = direction * SPEED

func change_animation():
	#y-axis is flipped in godot!!!
	if direction.y < 0:
		animated_sprite.play("run_back")
	elif direction.y > 0:
		animated_sprite.play("run_front")
	elif direction.x > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("idle_front")
	elif direction.x < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("idle_front")
	else:
		animated_sprite.play("idle_front")
