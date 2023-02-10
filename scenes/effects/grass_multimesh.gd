@tool
extends MultiMeshInstance3D

@export var target_path : NodePath
@export var source_path : NodePath

@export var recalculate_custom_instance : bool = false : set = _setrecalculatecustominstance
func _setrecalculatecustominstance(v : bool):
	if v:
		var target : MeshInstance3D = get_node(target_path)
		var source : MeshInstance3D = get_node(source_path)
		multimesh.instance_count = 0
		multimesh.set_use_colors(true)
		multimesh.set_use_custom_data(true)
		var floor_size := target.mesh.get_aabb()
		var ratio_size : float = floor_size.size.x/sqrt(65000)
		var half_way_size : float = ratio_size/2.0
		multimesh.instance_count = 65000
		var max : int = floor_size.size.x/ratio_size
		for idx in multimesh.instance_count:
			var w = idx % max
			var h = idx / max
			var pos := Vector3(h*ratio_size+randf_range(-half_way_size,half_way_size),0.0,w*ratio_size+randf_range(-half_way_size,half_way_size))
			multimesh.set_instance_color(idx,Color.DARK_GREEN.lerp(Color.GREEN_YELLOW,randf()*.33))
			multimesh.set_instance_transform(idx,Transform3D(Basis.IDENTITY.scaled(Vector3(5,5,5)),pos))
			multimesh.set_instance_custom_data(idx,Color(pos.x,pos.y,pos.z,1.0))
