extends pweapon


@export var damage: float
@export var hitscan_path_particle: PackedScene
@export var zoom_fov: float = 35
@onready var emission_point: Marker3D = $"Emission Point"
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

# Deal hitscan damage on attack
func leftclick():
	hitscan_damage(damage)
	audio_player.play(0)
	path_particle(hitscan_path_particle,emission_point)
	LeftClickCooldown.start(1)

# Zoom in
func rightclick():
	gvars.pcamera.fov = zoom_fov

# Zoom out
func rightclick_release():
	gvars.pcamera.reset_fov()
	print("zoom out")
