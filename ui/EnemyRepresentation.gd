extends HBoxContainer


func _ready() -> void:
	Events.connect("EnemyPresenceUpdated",enemy_presence_updated)
	enemy_presence_updated()

func enemy_presence_updated():
	if (get_tree() == null):
		return
	
	await get_tree().physics_frame
	
	var enemies := get_tree().get_nodes_in_group("Enemies")
	var current_amount : int = get_child_count()
	var new_amount : int = enemies.size()
	var diff : int = new_amount-current_amount

	if diff > 0:
		for i in diff:
			var new_enemy_icon = TextureRect.new()
			new_enemy_icon.texture = preload("res://icon.svg")
			new_enemy_icon.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
			new_enemy_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			add_child(new_enemy_icon)
	elif diff < 0:
		for i in abs(diff):
			get_child(i).queue_free()
