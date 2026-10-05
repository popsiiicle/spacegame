class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
@export var phantomcamera: PhantomCamera3D
@export var respawntimer: Timer
@export var respawntimerdisplay: Label
var player_id: int

static func create(deadplayer) -> void:
	#Adds deathcam to scene
	var DEATHCAM = deathcamscene.instantiate()
	gvars.level.add_sibling(DEATHCAM)
	DEATHCAM.player_id = int(deadplayer.get_name())
	
	# FIX: not working Makes the deathcam match the last position of the player's camera before death.  
	DEATHCAM.position = gvars.pcamera.global_position
	DEATHCAM.rotation = gvars.pcamera.global_rotation
	
	#activates camera
	DEATHCAM.make_current()
	# TODO: Make cam look at killer
	#DEATHCAM.phantomcamera.look_at_target = killer
	
func _ready():
	respawntimer.start()
	
func _process(_delta: float) -> void:
	var timerfloat: float = snapped(respawntimer.time_left,0.1)
	respawntimerdisplay.text = "Respawning in " + str(timerfloat)
func _on_timer_timeout() -> void:
	networkhandler.spawn_player.rpc(player_id)
	queue_free()
	# TODO respawn code
