class_name psniper extends pweapon

@export var damage: float
@export var hitscan_path_particle: PackedScene
@onready var emission_point: Marker3D = $Emission_Point

func leftclick():
	hitscandmg(damage)
	path_particle(hitscan_path_particle,emission_point)
	LeftClickCooldown.start(1)
	#Add effects here
