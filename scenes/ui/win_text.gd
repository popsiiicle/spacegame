extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playermanager.end_game.connect(_on_end_game)
	hide()

func _on_end_game(winner: String):
	text = winner + " Won!"
	show()
	await get_tree().create_timer(5).timeout
	hide()
