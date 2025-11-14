class_name pweaponhandler extends Node

@export var resource: pweaponres

func load_weapon(res) -> Node3D:
	var _weapon_instance = res.SCENE.instantiate()
	add_child(_weapon_instance)
	_weapon_instance.rotation = res.ROTATION
	_weapon_instance.position = res.POSITION
	_weapon_instance.scale = Vector3(res.SCALE,res.SCALE,res.SCALE)
	return _weapon_instance
