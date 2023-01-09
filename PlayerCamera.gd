extends Camera3D

@export var lookat_offset_position : Vector3 = Vector3(-5,5,5)
@export var player_rigid_body_path : NodePath
var player_rigid_body : RigidBody3D

func _ready() -> void:
	player_rigid_body = get_node(player_rigid_body_path)

func _physics_process(delta: float) -> void:
	var pos = player_rigid_body.global_transform.origin+lookat_offset_position
	look_at_from_position(pos,player_rigid_body.global_transform.origin,Vector3.UP)
