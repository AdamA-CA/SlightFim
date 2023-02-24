extends MeshInstance3D

@export var target_path : NodePath
var target : Node3D

func _ready() -> void:
	visible = true
	if target_path.is_empty() == false:
		target = get_node(target_path)

func _physics_process(_delta: float) -> void:
	if target:
		global_position = target.global_position
