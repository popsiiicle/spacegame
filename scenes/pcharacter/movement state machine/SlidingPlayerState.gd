class_name SlidingState


extends PlayerMovementState


var camvector: Vector3:
	get:
		return -gvars.pcamera.global_transform.basis.z.normalized()
 ##The direction the player's camera is facing
const SLIDEBOOST = 4 ## The intitial boost you get while initially sliding on a wall
var slidevector: Vector3

#jumping off wall vectors
var jumpboost: Vector3 ##The velocity increase you get after jumping on a wall
var wallnorm: Vector3 ##The wall normal you are jumping off of
const JUMPBOOST = 4 ##Constant for how far you jump off of a wall
var jumpangle: float ##The angle between camera direction and wall normal vectors



func enter():

	#cancels out velocity moving towards the wall
	
	wallnorm = gvars.player.currentcollision.get_normal()
	if PLAYER.velocity.dot(wallnorm) < 0:
		PLAYER.velocity = gvars.player.velocity.slide(wallnorm).normalized() * PLAYER.velocity.length()
		
	#give player boost upon touching the wall
	PLAYER.velocity = PLAYER.velocity.normalized()*(PLAYER.velocity.length() + SLIDEBOOST) #Add more later
	
	
func physics_update(_delta):
	if !is_multiplayer_authority(): return

	#DI while sliding code (might add later, probably all wrong)
	
	#cameradirection = 
	#camera direction cross wallnorm
	#basis -cross, wallnorm, camera slide
	#vector3transform = vector2d yada yada
	#basis.xform
	
	
	#Jump away from wall
	if Input.is_action_pressed("jump"):
		
		
		
		## Legacy code
		#jumpboost = camvector*JUMPBOOST
		#jumpangle = jumpboost.angle_to(wallnorm)
		##jumpboost is a vector that has the magnitude JUMPBOOST and points to where you are looking
		##clamps jumpboost so that it is at least 25 degrees away from the wall (remove the other part later)
		#rotaxis = jumpboost.cross(wallnorm).normalized()
		#rotangle = -clamp(0,0.349066-jumpangle,1.13446-jumpangle)
		#jumpboost = jumpboost.rotated(rotaxis,rotangle)
		
		#TODO: make sliding go faster than jumping so that edge cancelling is possible.  velocity makes jumping faster and sliding faster than that.  
		
		camvector = -gvars.pcamera.global_transform.basis.z.normalized()
		jumpboost = camvector * JUMPBOOST
		PLAYER.velocity = jumpboost + jumpboost.normalized() * gvars.player.velocity.length()
		transition.emit("SpaceState")
		
