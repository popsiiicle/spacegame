class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
#@export var phantomcamera: PhantomCamera3D
@export var respawntimer: Timer
@export var respawntimerdisplay: Label
@export var respawnGUI: VBoxContainer
var playerid: int

#runs on both client and server, but should only have an effect on the client that actually died.  
static func create(deadplayer: int) -> void:
	#Adds deathcam to scene
	var DEATHCAM = deathcamscene.instantiate()
	DEATHCAM.set_multiplayer_authority(deadplayer)
	gvars.level.add_child(DEATHCAM,true)
	
	#set playerid variable, used to spawn player.  
	DEATHCAM.playerid = int(deadplayer)
	
	gfunc.cprint(DEATHCAM,"Deathcamera for player " + str(deadplayer) + " has been created.") 

	
	# FIX: not working Makes the deathcam match the last position of the player's camera before death.  
	#DEATHCAM.position = gvars.pcamera.global_position
	#DEATHCAM.rotation = gvars.pcamera.global_rotation
	
	#activates camera
	
	# TODO: Make cam look at killer
	#DEATHCAM.phantomcamera.look_at_target = killer
	
func _ready():
	respawntimer.start()
	if is_multiplayer_authority():
		make_current()
	else:
		respawnGUI.hide()


func _process(_delta: float) -> void:
	#update respawn timer
	var timerfloat: float = snapped(respawntimer.time_left,0.1)
	respawntimerdisplay.text = "Respawning in " + str(timerfloat)
	

#when the timer runs out, spawn the player on the server and then delete all instances of the node
func _on_timer_timeout() -> void:
	if multiplayer.is_server():
		networkhandler.spawn_player(playerid)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	queue_free()
	# TODO respawn code
