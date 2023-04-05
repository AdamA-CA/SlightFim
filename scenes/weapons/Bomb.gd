extends RigidBody3D

var exploded_already : bool = false

func explode():
	if exploded_already:
		return
	exploded_already = true

	var particles = preload("res://scenes/effects/gpu_particles_3d.tscn").instantiate()
	get_tree().get_current_scene().add_child(particles)
	particles.scale = Vector3(5,5,5)
	particles.global_position = global_position
	particles.emitting = true
	$Area3D.monitoring = true
	await get_tree().physics_frame
	await get_tree().physics_frame
	queue_free()

func _on_body_entered(body: Node) -> void:
	explode()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.has_method("explode")):
		body.explode()
	if body is Player:
		body.kill_player()
