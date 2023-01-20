extends MeshInstance3D

var mat : StandardMaterial3D = preload("res://debug/debug_arrow.material")
var max_known_speed : float = 0.0

func _physics_process(delta: float) -> void:
	print("a")
	look_at(global_position+(get_parent().linear_velocity.normalized()),Vector3.UP)
	
	var cur_speed_mag = get_parent().linear_velocity.length();
	max_known_speed = max(max_known_speed,cur_speed_mag)
	var offset : float = lerp(0.0,1.0,cur_speed_mag/max_known_speed)
	var clr : Color = lerp(Color.BLUE,Color.RED,offset)
	mat.albedo_color = clr
	
	scale = Vector3(1,1,offset)

func _on_visibility_changed() -> void:
	set_physics_process(visible)
