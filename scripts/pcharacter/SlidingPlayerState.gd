class_name SlidingPlayerState


extends PlayerMovementState


var camvector: Vector3 ##The direction the player's camera is facing
const SLIDEBOOST = 6 ## The intitial boost you get while initially sliding on a wall

#jumping off wall vectors
var jumpboost: Vector3 ##The velocity increase you get after jumping on a wall
var wallnorm: Vector3 ##The wall normal you are jumping off of
const JUMPBOOST = 12 ##Constant for how far you jump off of a wall
var jumpangle: float ##The angle between camera direction and wall normal vectors
var rotaxis: Vector3 ##cross of jumpangle and wallnorm
var rotangle: float ##angle the jumpangle is rotated so that it faces away from the while, while is still influenced by direction.



func enter():

	#cancels out velocity moving towards the wall
	wallnorm = PLAYER.get_wall_normal()
	if PLAYER.velocity.dot(wallnorm) < 0:
		PLAYER.velocity = PLAYER.velocity.slide(wallnorm)
		
	#give player boost upon touching the wall
	PLAYER.velocity = PLAYER.velocity.normalized()*(PLAYER.velocity.length() + SLIDEBOOST) #Add more later
	
	
func physics_update(_delta):
	
	#DI while sliding code (might add later, probably all wrong)
	
	#cameradirection = 
	#camera direction cross wallnorm
	#basis -cross, wallnorm, camera slide
	#vector3transform = vector2d yada yada
	#basis.xform
	
	
	#Jump away from wall
	if Input.is_action_pressed("jump"):
		camvector = -gvars.pcamera.global_transform.basis.z.normalized()
		jumpboost = camvector*JUMPBOOST
		jumpangle = jumpboost.angle_to(wallnorm)
		#jumpboost is a vector that has the magnitude JUMPBOOST and points to where you are looking
		
		#clamps jumpboost so that it is at least 25 degrees away from the wall (remove the other part later)
		rotaxis = jumpboost.cross(wallnorm).normalized()
		rotangle = -clamp(0,0.349066-jumpangle,1.13446-jumpangle)
		jumpboost = jumpboost.rotated(rotaxis,rotangle)
		
		#adds the jumpboost
		PLAYER.velocity = PLAYER.velocity + jumpboost
		
	#go to spacestate if the player isn't on the wall.  
	if gvars.player.is_on_wall() == false:
		transition.emit("SpaceState")
