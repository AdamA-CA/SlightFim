extends Node3D

const BASE_SPEED : float = 500

var missile := preload("res://scenes/weapons/missile.tscn")
@onready var parent = get_parent()

@export var shooting_interval : float = .5
@export var self_explosion_wait_time : float = 1.5
@export_range(0.0,2.0) var projectile_speed : float = 1.0
@export_range(100,1500) var max_shooting_distance : float = 600
@export_range(1,20.0,.5) var spread : float = 1.0

var timer := Timer.new()

func _input(event: InputEvent) -> void:
	if event.is_action_released("DebugTest"):
		var player : Node3D = get_tree().get_nodes_in_group("Player")[0]
		spawn_missle(player)

func _ready() -> void:
	timer.wait_time = shooting_interval
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout",shoot)

func shoot():
	var player : Node3D = get_tree().get_nodes_in_group("Player")[0]
	if(player.get_global_position().distance_to(parent.global_position) > max_shooting_distance):
		print("player too far")
		return
	spawn_missle(player)

func spawn_missle(player):
	var new_missile = missile.instantiate()
	new_missile.origin_node = owner
	new_missile.position = global_position
	new_missile.get_node("Timer").wait_time = self_explosion_wait_time
	get_tree().root.add_child(new_missile)
	var offset : Vector3 = Vector3(randf_range(-spread,spread),randf_range(-spread,spread),randf_range(-spread,spread))
	var dir : Vector3 = new_missile.global_position.direction_to(player.get_global_position()+offset)
	new_missile.linear_velocity = dir *BASE_SPEED*projectile_speed
	new_missile.target = player
