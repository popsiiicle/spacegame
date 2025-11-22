class_name prlauncher extends pweapon

@export var projectile: PackedScene

func leftclick():
	spawn_projectile(projectile,-gvars.pcamera.global_transform.basis.z)
