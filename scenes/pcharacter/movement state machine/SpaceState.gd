class_name SpaceState
extends PlayerMovementState
## Player state for when the playercharacter is floating in space (default state)


const THRUSTVEL = 30 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 30 ## At this speed, the thrusters shut off
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
	#directional movement code (pressing buttons makes you move in that direction in space)
	if direction_3d:
		velocity += direction_3d*THRUSTVEL*delta
		
		#limits velocity to airspeed (fix so only directional input will not increase airspeed
		if velocity.length() >= TOPAIRSPEED:
			velocity = velocity*(TOPAIRSPEED/velocity.length())
			
	
	# Add a slowdown later
	if Input.is_action_just_pressed("stop"):
		velocity = Vector3.ZERO
	#re-update global var
	#there's a cleaner way to do this, fix later
	gvars.player.velocity = velocity
	gvars.debug.add_property("Velocity",velocity,60)
	gvars.debug.add_property("pVelocity",gvars.player.velocity,61)

	#go to slidingplayerstate upon touching a wall
	if gvars.player.is_on_wall() == true:
		transition.emit("SlidingState")
	
		
