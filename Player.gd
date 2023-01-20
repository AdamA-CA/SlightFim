extends RigidBody3D

@export var thrust : float = 10.0
@export var uplift_strength : float = .5

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _physics_process(delta):
	pass

func _integrate_forces(state):
	if Input.is_action_pressed("ui_accept"):
		state.apply_impulse(-global_transform.basis.z * thrust * mass)
	state.apply_impulse(Vector3.UP * uplift_strength * abs(state.linear_velocity.z))

	if Input.is_action_pressed("ui_left"):
		state.apply_torque_impulse(global_transform.basis.z * mass)
	if Input.is_action_pressed("ui_right"):
		state.apply_torque_impulse(-global_transform.basis.z * mass)
	if Input.is_action_pressed("ui_up"):
		state.apply_torque_impulse(-global_transform.basis.x * mass)
	if Input.is_action_pressed("ui_down"):
		state.apply_torque_impulse(global_transform.basis.x * mass)
