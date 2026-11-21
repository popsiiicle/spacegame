extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 0
	max_value = Player.DASHCD
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(gvars.player):
		value = max_value - gvars.player.DashCD.time_left
	if value == max_value:
		value = 0
	#HACK Enable Later
