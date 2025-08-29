class_name SlidingPlayerState

extends PlayerMovementState

var lrinput = 0 ##The value used to determine left right input 
var lrcontrol = 0 ##The output used to determine left right drift during the slide

func enter():
	var player = gvars.player
	var wallnorm = player.get_wall_normal()
	if player.velocity.dot(wallnorm) < 0:
		player.velocity = player.velocity.slide(wallnorm)
	gvars.player.velocity = player.velocity

func physics_update(delta):
	lrinput = -1 * int(Input.is_action_pressed("left")) + 1 * int(Input.is_action_pressed("right"))
	gvars.debug.add_property("lrinput",lrinput,7)
	
	if Input.is_action_pressed("jump"):
		
	if gvars.player.is_on_wall() == false:
		transition.emit("SpaceState")
	
