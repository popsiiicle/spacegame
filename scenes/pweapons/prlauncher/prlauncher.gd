class_name prlauncher extends pweapon

@export var projectile: PackedScene
@onready var launchpoint := $LaunchPoint

func leftclick():
	spawn_projectile(projectile,-camera.global_transform.basis.z, launchpoint)
	$AudioStreamPlayer3D.play(0)
	LeftClickCooldown.start(.66)
