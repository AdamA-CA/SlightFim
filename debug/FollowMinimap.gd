extends MeshInstance3D

@export var player_rigid_body_path : NodePath
var player_rigid_body : RigidBody3D

func _ready() -> void:
	player_rigid_body = get_node(player_rigid_body_path)

func _physics_process(delta: float) -> void:
	global_position = player_rigid_body.global_position
