extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Timer.new() #HACK: make it actually update
	gvars.player.healthlogic.health_changed.connect(on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_health_changed(health):
	value = health
