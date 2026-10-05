extends pweapon


@export var damage: float
@export var hitscan_path_particle: PackedScene
@export var zoom_fov: float = 35
@onready var emission_point: Marker3D = $"Emission Point"
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
var scopeinitialized := false
var scopescene := preload("res://scenes/pweapons/psniper/sniperscope.tscn")
# Deal hitscan damage on attack
func leftclick():
	hitscan_damage(damage)
	audio_player.play(0)
	path_particle(hitscan_path_particle,emission_point)
	LeftClickCooldown.start(1)

# Zoom in

var scope: Control
func rightclick():
	#zoom
	camera.fov = zoom_fov
	
	#add scope as child if it isn't already
	if !scopeinitialized:
		scope = scopescene.instantiate()
		add_child(scope)
	
	#show scope and hide crosshair
	scope.show()
	gvars.hud.crosshairsprite.hide()

#zoom out
func rightclick_release():
	camera.reset_fov()
	scope.hide()
	gvars.hud.crosshairsprite.show()
