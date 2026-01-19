class_name psniper extends pweapon


@export var damage: float
@export var hitscan_path_particle: PackedScene
var zoom_fov: float = 35
@onready var emission_point: Marker3D = $"Emission Point"
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func leftclick():
	hitscan_damage(damage)
	audio_player.play(0)
	path_particle(hitscan_path_particle,emission_point)
	LeftClickCooldown.start(1)
	
func rightclick():
	gvars.pcamera.fov = zoom_fov
	print("zoom in")
	
func rightclickrelease():
	gvars.pcamera.reset_fov()
	print("zoom out")
