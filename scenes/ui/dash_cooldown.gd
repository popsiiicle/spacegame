extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if gvars.player is Node:
		value = 1 - gvars.player.DashCD.time_left
	if value == 1:
		value = 0
	#TODO: make it not call every frame
