class_name SpaceState
extends PlayerMovementState
## Player state for when the playercharacter is floating in the air (default state)


const THRUSTVEL = 30 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 30 ## At this speed, the thrusters shut off
var velocity = Vector3.ZERO ## Shortcut for the player's velocity
var direction_3d = Vector3.ZERO ## Shortcut for the player's input in player.gd

#func update(delta):
	
func physics_update(delta):

	
	#shortcut vars
	direction_3d = PLAYER.direction_3d
	velocity = PLAYER.velocity
	
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
	PLAYER.velocity = velocity
	

	
	#go to slidingplayerstate upon touching a wall
	if gvars.player.is_on_wall() == true:
		transition.emit("SlidingPlayerState")
	
		
