class_name SlidingPlayerState

extends PlayerMovementState


func update(delta):
	if gvars.player.is_on_wall() == false:
		transition.emit("SpaceState")
