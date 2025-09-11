class_name SpaceState
extends PlayerMovementState

const THRUSTVEL = 30 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 30 ## At this speed, the thrusters shut off
var velocity = Vector3.ZERO ## Shortcut for the player's velocity
var direction_3d = Vector3.ZERO ## Shortcut for the player's input in player.gd

#func update(delta):
	
func physics_update(delta):
		#floaty code
	direction_3d = PLAYER.direction_3d
	velocity = PLAYER.velocity
	if direction_3d:
		velocity += direction_3d*THRUSTVEL*delta
		if velocity.length() >= TOPAIRSPEED:
			velocity = velocity*(TOPAIRSPEED/velocity.length())
			#combine to speed limitone line later
	PLAYER.velocity = velocity
	if gvars.player.is_on_wall() == true:
		transition.emit("SlidingPlayerState")
	
		
