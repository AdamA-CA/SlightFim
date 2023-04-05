extends Node

var cur_position : Vector2
var dir : Vector2

@onready var center : Vector2 = get_viewport().size/2

func consume_dir() -> Vector2:
	var temp : Vector2 = dir
	dir = Vector2()
	return temp

#func _process(delta: float) -> void:
#	Input.warp_mouse(center)
#	DisplayServer.warp_mouse(center)

func process_dir(event : InputEventMouseMotion):
	if cur_position == center:
		print("center!")
		return
	
	dir = cur_position-event.global_position
	cur_position = event.global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		process_dir(event)
		Input.warp_mouse(center)
		DisplayServer.warp_mouse(center)


