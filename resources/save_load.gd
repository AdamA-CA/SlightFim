extends Node

var save_resource := preload("res://resources/save_resource.tres")

func _ready() -> void:
	loadSave()

func save():
	var error := ResourceSaver.save(save_resource,"user://memory.tres")

func loadSave():
	var saved_resource_from_disk := ResourceLoader.load("user://memory.tres") as SaveResource
	if saved_resource_from_disk != null:
		save_resource.high_score = saved_resource_from_disk.high_score
