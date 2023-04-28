extends Timer

func _on_timeout() -> void:
	if (get_parent().has_method("explode")):
		get_parent().explode()
