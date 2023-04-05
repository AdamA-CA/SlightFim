extends Control

@onready var player : RigidBody3D = get_parent().get_node("Player")
@onready var label : Label = $Label

func _physics_process(delta: float) -> void:
	var output : String = "Speed = "+str(int(player.linear_velocity.length()))+"ms"
	output += '\n'+"Position = "+str(player.global_position)
	label.text = output

func _input(event: InputEvent) -> void:
	if event.is_action_released("Deubg_Restart"):
		Engine.time_scale = 1.0
		load("res://visuals/world/envrionment.res").adjustment_saturation = 1
		load("res://visuals/world/envrionment.res").adjustment_contrast = 1
		get_tree().reload_current_scene()
	if event.is_action_released("Debug_UI_Toggle"):
		if visible:
			hide()
			for node in get_tree().get_nodes_in_group("DebugVisibility"):
				node.hide()
		else:
			show()
			for node in get_tree().get_nodes_in_group("DebugVisibility"):
				node.show()
