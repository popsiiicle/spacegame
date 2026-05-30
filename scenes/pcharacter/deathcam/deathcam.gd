class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
@export var phantomcamera: PhantomCamera3D

static func create(_deadplayer) -> void:
	var DEATHCAM = deathcamscene.instantiate()
	gvars.level.add_sibling(DEATHCAM)
	gfunc.cprint(DEATHCAM,gvars.pcamera.get_multiplayer_authority())
	
	#Makes the deathcam match the last position of the player's camera before death.  TODO, not working
	DEATHCAM.position = gvars.pcamera.global_position
	DEATHCAM.rotation = gvars.pcamera.global_rotation
	
	#activates camera
	DEATHCAM.make_current()
	# TODO: Make cam look at killer
	#DEATHCAM.phantomcamera.look_at_target = killer
	
