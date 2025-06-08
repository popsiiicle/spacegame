class_name SpaceState

extends State

func update(delta):
	if gvars.player.touching_surface == true:
		transition.emit("SlidingPlayerState")
