extends CharacterBody2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#read keyboardinput, this returns -1, 0, 1
	var horizontalDirection = Input.get_axis("move_left", "move_right")
	var verticalDirection = Input.get_axis("move_down", "move_up")
	
	if verticalDirection > 0:
		if horizontalDirection > 0:
			print("move up right")
		elif horizontalDirection < 0:
			print("move up left")
		else:
			print("move up")
			
	elif verticalDirection < 0:
		if horizontalDirection > 0:
			print("move down right")
		elif horizontalDirection < 0:
			print("move down left")
		else:
			print("move down")
		
	elif horizontalDirection > 0:
		print("move right")
	elif horizontalDirection < 0:
		print("move left")
