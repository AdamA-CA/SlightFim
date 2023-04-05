extends Node

var timer : Timer

func _ready() -> void:
	#DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released("Quit"):
		get_tree().quit()
