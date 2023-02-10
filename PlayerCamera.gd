extends Camera3D

@export var lookat_offset_position : Vector3 = Vector3(-5,5,5)
@export var player_rigid_body_path : NodePath
@export var camera_position_marker : Marker3D
@export var follow_speed : float = 25.0
@export var lookat_distance : float = 5.0
var player_rigid_body : RigidBody3D

func _ready() -> void:
	player_rigid_body = get_node(player_rigid_body_path)

func _physics_process(delta: float) -> void:
	var pos = camera_position_marker.global_transform.origin#+lookat_offset_position
	var offset = camera_position_marker.global_position.distance_to(global_position)
	pos = lerp(global_position,pos,clamp(delta*follow_speed*(player_rigid_body.linear_velocity.length()/800),0.0,1.0))
	look_at_from_position(pos,player_rigid_body.global_transform.origin,Vector3.UP)
