extends Node

var icon_map : Dictionary = {
	KEY_UP: preload("res://Assets/Sprites/Icons/Key_Up.png"),
	KEY_DOWN: preload("res://Assets/Sprites/Icons/Key_Down.png"),
	KEY_LEFT: preload("res://Assets/Sprites/Icons/Key_Left.png"),
	KEY_RIGHT: preload("res://Assets/Sprites/Icons/Key_Right.png"),
	KEY_F1: preload("res://Assets/Sprites/Icons/Key_F1.png"),
	KEY_F2: preload("res://Assets/Sprites/Icons/Key_F2.png"),
	KEY_F3: preload("res://Assets/Sprites/Icons/Key_F3.png"),
	KEY_F4: preload("res://Assets/Sprites/Icons/Key_F4.png"),
	KEY_F5: preload("res://Assets/Sprites/Icons/Key_F5.png"),
	KEY_F6: preload("res://Assets/Sprites/Icons/Key_F6.png"),
	KEY_F7: preload("res://Assets/Sprites/Icons/Key_F7.png"),
	KEY_F8: preload("res://Assets/Sprites/Icons/Key_F8.png"),
	KEY_F9: preload("res://Assets/Sprites/Icons/Key_F9.png"),
	KEY_F10: preload("res://Assets/Sprites/Icons/Key_F10.png"),
	KEY_F11: preload("res://Assets/Sprites/Icons/Key_F11.png"),
	KEY_F12: preload("res://Assets/Sprites/Icons/Key_F12.png"),
	KEY_A: preload("res://Assets/Sprites/Icons/Key_A.png"),
	KEY_B: preload("res://Assets/Sprites/Icons/Key_B.png"),
	KEY_C: preload("res://Assets/Sprites/Icons/Key_C.png"),
	KEY_D: preload("res://Assets/Sprites/Icons/Key_D.png"),
	KEY_E: preload("res://Assets/Sprites/Icons/Key_E.png"),
	KEY_F: preload("res://Assets/Sprites/Icons/Key_F.png"),
	KEY_G: preload("res://Assets/Sprites/Icons/Key_G.png"),
	KEY_H: preload("res://Assets/Sprites/Icons/Key_H.png"),
	KEY_I: preload("res://Assets/Sprites/Icons/Key_I.png"),
	KEY_J: preload("res://Assets/Sprites/Icons/Key_J.png"),
	KEY_K: preload("res://Assets/Sprites/Icons/Key_K.png"),
	KEY_L: preload("res://Assets/Sprites/Icons/Key_L.png"),
	KEY_M: preload("res://Assets/Sprites/Icons/Key_M.png"),
	KEY_N: preload("res://Assets/Sprites/Icons/Key_N.png"),
	KEY_O: preload("res://Assets/Sprites/Icons/Key_O.png"),
	KEY_P: preload("res://Assets/Sprites/Icons/Key_P.png"),
	KEY_Q: preload("res://Assets/Sprites/Icons/Key_Q.png"),
	KEY_R: preload("res://Assets/Sprites/Icons/Key_R.png"),
	KEY_S: preload("res://Assets/Sprites/Icons/Key_S.png"),
	KEY_T: preload("res://Assets/Sprites/Icons/Key_T.png"),
	KEY_U: preload("res://Assets/Sprites/Icons/Key_U.png"),
	KEY_V: preload("res://Assets/Sprites/Icons/Key_V.png"),
	KEY_W: preload("res://Assets/Sprites/Icons/Key_W.png"),
	KEY_X: preload("res://Assets/Sprites/Icons/Key_X.png"),
	KEY_Y: preload("res://Assets/Sprites/Icons/Key_Y.png"),
	KEY_Z: preload("res://Assets/Sprites/Icons/Key_Z.png"),
	KEY_PERIOD: preload("res://Assets/Sprites/Icons/Key_Period.png"),
	KEY_COMMA: preload("res://Assets/Sprites/Icons/Key_Comma.png"),
	KEY_QUOTELEFT: preload("res://Assets/Sprites/Icons/Key_QuoteLeft.png"),
	KEY_BRACKETLEFT: preload("res://Assets/Sprites/Icons/Key_BracketLeft.png"),
	KEY_BRACKETRIGHT: preload("res://Assets/Sprites/Icons/Key_BracketRight.png"),
	KEY_EQUAL: preload("res://Assets/Sprites/Icons/Key_Equal.png"),
	KEY_MINUS: preload("res://Assets/Sprites/Icons/Key_Minus.png"),
	KEY_QUESTION: preload("res://Assets/Sprites/Icons/Key_Question.png"),
	KEY_SLASH: preload("res://Assets/Sprites/Icons/Key_Slash.png"),
	KEY_BACKSLASH: preload("res://Assets/Sprites/Icons/Key_Backslash.png"),
	KEY_SEMICOLON: preload("res://Assets/Sprites/Icons/Key_Semicolon.png"),
}	

func get_icon_for_event(event: InputEvent) -> Texture:
	if event is InputEventKey:
		var keycode = event.physical_keycode
		if icon_map.has(keycode):
			return icon_map[keycode]
	elif event is InputEventJoypadButton:
		var button_index = event.button_index
		if icon_map.has(button_index):
			return icon_map[button_index]
	return null