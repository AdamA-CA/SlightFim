extends Marker3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D



func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if mesh_instance_3d.get_scale().x < 1:
			mesh_instance_3d.set_scale(mesh_instance_3d.get_scale()*1.1+Vector3(.01,.01,.01))
	else:
		mesh_instance_3d.set_scale(mesh_instance_3d.get_scale()*.93)

	mesh_instance_3d.scale.z = lerp(.25,1.0,mesh_instance_3d.get_scale().x)
	mesh_instance_3d.position.z = lerp(-1.5,1.5,mesh_instance_3d.get_scale().x)
