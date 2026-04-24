class_name prlauncher extends pweapon

@export var projectile: PackedScene
@onready var launchpoint := $LaunchPoint
@onready var projowner: Player = self.get_parent().get_parent().get_parent().get_parent().get_parent()
func leftclick():
	spawn_projectile(projectile,-camera.global_transform.basis.z, launchpoint, projowner)
	$AudioStreamPlayer3D.play(0)
	LeftClickCooldown.start(.66)
