class_name prlauncher extends pweapon

@export var Projectile: PackedScene

func leftclick():
	spawn_projectile(Projectile,-gvars.pcamera.global_transform.basis.z)
	
