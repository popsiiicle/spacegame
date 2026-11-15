extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gvars.player.healthlogic.health_changed.connect(on_health_changed)
	value = Player.MAXHEALTH #HACK: link to health value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_health_changed(health):
	value = health
