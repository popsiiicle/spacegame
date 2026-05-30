class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
@export var phantomcamera: PhantomCamera3D
var player_id: int

static func create(deadplayer) -> void:
	#Adds deathcam to scene
	var DEATHCAM = deathcamscene.instantiate()
	gvars.level.add_sibling(DEATHCAM)
	DEATHCAM.player_id = int(deadplayer.get_name())
	
	# FIX, not working Makes the deathcam match the last position of the player's camera before death.  
	DEATHCAM.position = gvars.pcamera.global_position
	DEATHCAM.rotation = gvars.pcamera.global_rotation
	
	#activates camera
	DEATHCAM.make_current()
	# TODO: Make cam look at killer
	#DEATHCAM.phantomcamera.look_at_target = killer
	


func _on_timer_timeout() -> void:
	networkhandler.spawn_player.rpc(player_id)
	# TODO respawn code
