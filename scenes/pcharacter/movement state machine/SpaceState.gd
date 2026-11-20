class_name SpaceState
extends PlayerMovementState
## Player state for when the playercharacter is floating in space (default state)


const THRUSTVEL = 40 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 17 ## At this speed, the thrusters shut off
var velocity = Vector3.ZERO ## Shortcut for the player's velocity
var direction_3d = Vector3.ZERO ## Shortcut for the player's input in player.

var framecount = 0


func physics_update(delta):
	if !is_multiplayer_authority(): return
	
	#shortcut vars
	direction_3d = gvars.player.direction_3d
	velocity = gvars.player.velocity
	
	#directional movement code (pressing buttons makes you move in that direction in space)
	var oldspeed: float = velocity.length()
	if direction_3d.length() > Vector3.ZERO.length():
		velocity += direction_3d*THRUSTVEL*delta
		#prevent strafing from accelerating infinitely
		if velocity.length() >= oldspeed and oldspeed >= 30:
			velocity *= oldspeed/velocity.length()
			
			
			
	#TODO: Add a slowdown later
	if Input.is_action_just_pressed("stop"):
		velocity = Vector3.ZERO
	#re-update global var
	#there's a cleaner way to do this, fix later
	gvars.player.velocity = velocity

	#Accelerate based off of zones

	#go to slidingplayerstate upon touching a wall
	if gvars.player.currentcollision != null:
		transition.emit("SlidingState")
	
