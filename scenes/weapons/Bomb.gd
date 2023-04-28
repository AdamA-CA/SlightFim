extends RigidBody3D

@export var explosion_kills_player : bool = true
@export var explosion_kills_enemies : bool = true
@export var explosion_color : Color = Color.MEDIUM_PURPLE

var exploded_already : bool = false
var origin_node : Node = null

@onready var timer := $Timer

func explode():
	if exploded_already:
		return
	exploded_already = true

	$AnimationPlayer.play("FlashBeforeExplode")
	await $AnimationPlayer.animation_finished

	var particles = preload("res://scenes/effects/gpu_particles_3d.tscn").instantiate()
	particles.process_material.set("color", explosion_color)
	get_tree().get_current_scene().add_child(particles)
	particles.scale = Vector3(5,5,5)
	particles.global_position = global_position
	particles.emitting = true
	$Area3D.monitoring = true
	$MissleMask.monitoring = true
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	queue_free()

func _on_body_entered(body: Node) -> void:
	if origin_node == body:
		return
	explode()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == origin_node:
		return

	if (body.has_method("explode")) && explosion_kills_enemies:
		body.explode()
	if body is Player && explosion_kills_player:
		body.kill_player()

func _on_missle_mask_body_entered(body: Node3D) -> void:
	if body == self:
		return

	if is_instance_valid(body):
		body.explode()

func _on_player_closeness_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		$PlayerClosenessDetector/CollisionShape3D.disabled = true
		var time_left : float = timer.get_time_left()
		gravity_scale = 0
		linear_velocity *= .005
		if(time_left <= .5 || timer.is_stopped()):
			return
		timer.start(randf_range(.05,0.5))
