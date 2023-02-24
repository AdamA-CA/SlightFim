extends RigidBody3D

var player : RigidBody3D
var died : bool = false
var call_queue : Array[Callable] = []
var minimap_pin : Node

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	call_queue.push_back(normal_chase)
	spawnMinimapPin()

func spawnMinimapPin():
	var group = get_tree().get_nodes_in_group("EnemyMinimapNode")
	if group.is_empty():
		return
	
	minimap_pin = preload("res://scenes/minimap/minimap_pin.tscn").instantiate()
	group.front().add_child(minimap_pin)
	minimap_pin.target = self

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	for i in call_queue:
		i.call(state)

func normal_chase(state: PhysicsDirectBodyState3D):
	var dir := global_position.direction_to(player.global_position)
	dir.y = 0
	state.apply_central_impulse(dir*mass)

func create_death_impulse(state: PhysicsDirectBodyState3D):
	var dir := global_position.direction_to(player.global_position)
	state.apply_central_impulse(-dir*mass*10)

func _on_body_entered(body: Node) -> void:
	if body == player && died == false:
		call_queue.clear()
		call_queue.push_back(create_death_impulse)
		gravity_scale *= 10
		await get_tree().create_timer(1).timeout
		explode()

var exploded : bool = false

func explode():
	if exploded:
		return
	exploded = true

	if minimap_pin:
		minimap_pin.queue_free()
	$AudioStreamPlayer3D.play()
	$MeshInstance3D.hide()
	died = true
	$GPUParticles3D.emitting = true
	await get_tree().create_timer(1).timeout
	queue_free()
