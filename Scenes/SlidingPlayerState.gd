class_name SlidingPlayerState

extends PlayerMovementState

var transx ##The cross product of the wall normal and camera direction vector.  Used to calculate the change in velocity when sliding on a wall
var camvector: Vector3 ##The direction the player's camera is facing
const SLIDEBOOST = 9 ## The intitial boost you get while initially sliding on a wall
var jumpboost: Vector3 ##The velocity increase you get after jumping on a wall
var wallnorm: Vector3 ##The wall normal you are jumping off of
const JUMPBOOST = 3

func enter():
	wallnorm = PLAYER.get_wall_normal()
	gvars.debug.add_property("wallnorm",wallnorm,13)
	if PLAYER.velocity.dot(wallnorm) < 0:
		PLAYER.velocity = PLAYER.velocity.slide(wallnorm)
	PLAYER.velocity = PLAYER.velocity.normalized()*(PLAYER.velocity.length() + SLIDEBOOST) #Add more later
	
	
func physics_update(delta):
	#cameradirection = 
	
	#camera direction cross wallnorm
	
	#basis -cross, wallnorm, camera slide
	#vector3transform = vector2d yada yada
	#basis.xform
	
	if Input.is_action_pressed("jump"):
		camvector = -gvars.pcamera.global_transform.basis.z.normalized()
		jumpboost = camvector*JUMPBOOST
		var jumpangle = jumpboost.angle_to(wallnorm)
		# Find axis of rotation
		var rotaxis = jumpboost.cross(wallnorm).normalized()
		var rotangle = -clamp(0,0.349066-jumpangle,1.13446-jumpangle)
		gvars.debug.add_property("jumpangle",jumpangle,13)
		gvars.debug.add_property("clamped jump angle",rotangle,14)
		jumpboost = jumpboost.rotated(rotaxis,rotangle)
		PLAYER.velocity = PLAYER.velocity + jumpboost
	if gvars.player.is_on_wall() == false:
		transition.emit("SpaceState")
	
