extends CharacterBody2D

const SPEED = 130.0

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float):
	#read input
	get_input()
	#move character using buildin function
	move_and_slide()

func get_input():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
