extends Path3D

func _ready() -> void:
	top_level = true
	global_position = Vector3.ZERO
	curve.clear_points()

func add_points(pos : Vector3):
	curve.add_point(pos)
	if(curve.get_point_count() > 5):
		curve.remove_point(0)

func _on_timer_timeout() -> void:
	add_points(get_parent().global_position)
