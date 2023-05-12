extends ProgressBar

@onready var player : Player = $"../../Player"

func _ready() -> void:
	max_value = player.max_health
	value = player.max_health
	Events.connect("PlayerHealthUpdated",set_value)
