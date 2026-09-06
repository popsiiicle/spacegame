extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout  #HACK: make it actually update
	gvars.player.healthlogic.health_changed.connect(on_health_changed)
	value = 100 #HACK: link to health value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_health_changed(health):
	value = health
