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
		state.apply_impulse(Vector3.FORWARD * state.step * thrust)
		state.apply_impulse(Vector3.UP * state.step * uplift_strength * abs(state.linear_velocity.z))
