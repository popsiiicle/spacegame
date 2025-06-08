class_name SlidingPlayerState

extends State

func update(delta):
	if gvars.player.touching_surface == false:
		transition.emit("IdlePlayerState")
	
