extends Path3D

@export var length : int = 15
@export var target_node_path : NodePath
var target_node : Node3D

var frame : int = 0

func _ready() -> void:
	curve.clear_points()
	target_node = get_node(target_node_path)

func _physics_process(delta: float) -> void:
	curve.add_point(target_node.global_position+Vector3(randf(),randf(),randf())*.5)
	if curve.point_count > length:
		curve.remove_point(0)
