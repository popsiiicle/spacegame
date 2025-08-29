class_name SpaceState
extends PlayerMovementState

const THRUSTVEL = 10 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 30 ## At this speed, the thrusters shut off
var velocity = Vector3.ZERO

#func update(delta):
	
func physics_update(delta):
		#floaty code
	var direction_3d = gvars.player.direction_3d
	var velocity = gvars.player.velocity
	if direction_3d:
		velocity += direction_3d*THRUSTVEL*delta
		if velocity.length() >= TOPAIRSPEED:
			velocity = velocity*(TOPAIRSPEED/velocity.length())
			#combine to speed limitone line later
	gvars.player.velocity = velocity
	if gvars.player.is_on_wall() == true:
		transition.emit("SlidingPlayerState")
	
		
