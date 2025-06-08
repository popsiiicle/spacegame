class_name SlidingPlayerState

extends State

func update(delta):
	if gvars.player.is_on_wall() == false:
		transition.emit("SpaceState")
