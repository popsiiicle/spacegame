class_name SpaceState

extends State

func update(delta):
	if gvars.player.is_on_wall() == true:
		transition.emit("SlidingPlayerState")
