class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
@export var phantomcamera: PhantomCamera3D

static func create(deadplayer) -> void:
	var DEATHCAM = deathcamscene.instantiate()
	deadplayer.add_sibling(DEATHCAM)
	DEATHCAM.position = gvars.pcamera.position
	DEATHCAM.rotation = gvars.pcamera.rotation
	DEATHCAM.make_current()
	# TODO: Make cam look at killer
	#DEATHCAM.phantomcamera.look_at_target = killer
	
