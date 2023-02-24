extends RigidBody3D

@export var thrust : float = 10.0
@export var uplift_strength : float = .5

@onready var raycast := $RayCast3D
@onready var shoot_mesh : ImmediateMesh = $ShootLine.mesh
@onready var aim_reticle := $AimReticle

var particles = preload("res://scenes/effects/particles_now.material")
var aiming_mat = preload("res://visuals/player/aiming_recticle.material")

func _ready():
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var new_color := Color.WHITE
	var new_scale : float = 1.0 
	var col = raycast.get_collider()
	var pressing_shoot : bool = Input.is_action_just_pressed("Shoot")
	var pressing_bomb : bool = Input.is_action_just_pressed("Bomb")
	shoot_mesh.clear_surfaces()
	var z : float = raycast.target_position.z

	if col:
		z = to_local(raycast.get_collision_point()).z
		var col_can_explode : bool = col.has_method("explode")
		if col_can_explode:
			new_scale = 2.5
			new_color = Color.RED
			if pressing_shoot:
				col.explode()

	if pressing_shoot:
		make_shoot_line(z)

	if pressing_bomb:
		spawnBomb()

	aim_reticle.position = Vector3(0,0,z) # I want to make sure it's 0,0 on x and y
	aim_reticle.scale = Vector3(5,5,5)*new_scale
	aiming_mat.set("albedo_color",new_color)

func spawnBomb():
	pass

func make_shoot_line(z : float):
	var im : ImmediateMesh = $ShootLine.mesh
	im.surface_begin(Mesh.PRIMITIVE_LINES)
	
	im.surface_set_color(Color.RED)
	im.surface_add_vertex(Vector3(0,0,0))
	
	im.surface_set_color(Color.RED)
	im.surface_add_vertex(Vector3(0,0,z))
	im.surface_end()

var dir : Vector2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var center : Vector2 = get_viewport().get_window().size / 2.0
		print(event.position)
		dir = (event.position - center) *.005

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

	state.apply_torque_impulse(-dir.x * global_transform.basis.z * mass)
	state.apply_torque_impulse(dir.y * global_transform.basis.x * mass)
