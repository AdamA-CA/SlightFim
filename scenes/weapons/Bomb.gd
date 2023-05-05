extends RigidBody3D

@export var explosion_kills_player : bool = true
@export var explosion_kills_enemies : bool = true
@export var explosion_color : Color = Color.MEDIUM_PURPLE

var exploded_already : bool = false
var origin_node : Node = null
var target : RigidBody3D 
var targeting_strength : float = 0.01

@onready var timer := $Timer

func _ready() -> void:
	$PlayerClosenessDetector/MeshInstance3D.visible = false

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

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	$HappyTime.process_material.set("direction",linear_velocity.normalized())
	$HappyTime.process_material.set("inital_velocity_min",linear_velocity.length())
	if is_instance_valid(target):
		var perfect_direction : Vector3 = global_position.direction_to(target.global_position+target.linear_velocity)
		var current_velocity_direction := state.linear_velocity.normalized()
		current_velocity_direction = lerp(current_velocity_direction,perfect_direction,targeting_strength)
		state.linear_velocity = state.linear_velocity.length() * current_velocity_direction

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
		$PlayerClosenessDetector/MeshInstance3D.visible = true
		$PlayerClosenessDetector/CollisionShape3D.disabled = true
		var time_left : float = timer.get_time_left()
		gravity_scale = 0
		linear_velocity *= .1
		targeting_strength = 1.0
		if(time_left <= .5 || timer.is_stopped()):
			return
		timer.start(randf_range(.05,0.5))
