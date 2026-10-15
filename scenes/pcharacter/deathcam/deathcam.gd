class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
#@export var phantomcamera: PhantomCamera3D
@export var respawntimer: Timer
@export var respawntimerdisplay: Label
@export var respawnGUI: VBoxContainer
var playerid: int

static func create(deadplayer: int) -> void:
	#Adds deathcam to scene
	var DEATHCAM = deathcamscene.instantiate()
	DEATHCAM.set_multiplayer_authority(deadplayer)
	gvars.level.add_child(DEATHCAM)
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
	var timerfloat: float = snapped(respawntimer.time_left,0.1)
	respawntimerdisplay.text = "Respawning in " + str(timerfloat)
func _on_timer_timeout() -> void:
	if !is_multiplayer_authority(): return
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	networkhandler.spawn_player.rpc(playerid)
	queue_free()
	# TODO respawn code
