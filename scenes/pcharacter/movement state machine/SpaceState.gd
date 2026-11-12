class_name SpaceState
extends PlayerMovementState
## Player state for when the playercharacter is floating in space (default state)


const THRUSTVEL = 30 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 12 ## At this speed, the thrusters shut off
var velocity = Vector3.ZERO ## Shortcut for the player's velocity
var direction_3d = Vector3.ZERO ## Shortcut for the player's input in player.

var framecount = 0
func physics_update(delta):
	#await gvars.player.ready
	if !is_multiplayer_authority(): return
	#	gvars.debug.add_property("is_not_authority",gvars.player.get_owner().name,90)
	#else:
	#	gvars.debug.add_property("is_authority",gvars.player.get_owner().name,91)
	
	#shortcut vars
	direction_3d = gvars.player.direction_3d
	velocity = gvars.player.velocity
	gvars.debug.add_property("direction3d",direction_3d,405)

	#directional movement code (pressing buttons makes you move in that direction in space)
	#HACK add strafing against velocity
	var applythrust: bool ## whether to apply thrust to the player
	applythrust = (velocity.length() <= TOPAIRSPEED or velocity.dot(direction_3d.transform(gvars.player.pcamera.position)))
	if direction_3d.length() > Vector3.ZERO.length() and :
		velocity += direction_3d*THRUSTVEL*delta

	
	# Add a slowdown later
	if Input.is_action_just_pressed("stop"):
		velocity = Vector3.ZERO
	#re-update global var
	#there's a cleaner way to do this, fix later
	gvars.player.velocity = velocity

	#go to slidingplayerstate upon touching a wall
	if gvars.player.currentcollision != null:
		transition.emit("SlidingState")
	
