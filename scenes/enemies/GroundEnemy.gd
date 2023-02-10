extends RigidBody3D

@export var player : RigidBody3D

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var dir := global_position.direction_to(player.global_position)
	dir.y = 0
	state.apply_central_impulse(-dir*mass)
