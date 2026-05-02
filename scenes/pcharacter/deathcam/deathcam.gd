class_name DeathCamera extends Camera3D

static var deathcamscene: PackedScene = load("res://scenes/pcharacter/deathcam/deathcam.tscn")
@export var phantomcamera: PhantomCamera3D

static func create_death_camera(deadplayer,killer) -> void:
	var DEATHCAM = deathcamscene.instantiate()
	deadplayer.add_sibling(DEATHCAM)
	DEATHCAM.position = deadplayer.position
	DEATHCAM.phantomcamera.look_at_target = killer

func _ready():
	await gvars.player.queue_free()
	make_current()
