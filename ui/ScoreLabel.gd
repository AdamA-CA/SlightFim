extends Label

var score : int = 0

func _ready() -> void:
	update_score_text()
	Events.connect("EnemyKilled",enemy_killed)

func enemy_killed(enemy : String):
	if enemy == "Basic":
		score += 50
	else:
		score += 100
	update_score_text()

func update_score_text():
	var sr := preload("res://resources/save_resource.tres")
	if score > sr.high_score:
		sr.high_score = score
		SaveLoad.save()
	text = str(score)+" / "+str(sr.high_score)

