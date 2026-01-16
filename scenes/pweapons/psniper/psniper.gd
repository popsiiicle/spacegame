class_name psniper extends pweapon


@export var damage: float
@export var hitscan_path_particle: PackedScene
var zoom_fov: float = 35
@onready var emission_point: Marker3D = $"Emission Point"
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func leftclick():
	hitscandmg(damage)
	audio_player.play(0)
	path_particle(hitscan_path_particle,emission_point)
	LeftClickCooldown.start(1)
	#Add effects here

func rightclick():
	gvars.pcamera.fov = zoom_fov
	print("zoom in")
func rightclickrelease():
	gvars.pcamera.resetfov()
	print("zoom out")
