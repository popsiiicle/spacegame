class_name WeaponLoader extends Node

func load_weapon(res):
	if _weapon_instance:
		_weapon_instance.queue_free()
	if res.SCENE:
		_weapon_instance = res.SCENE.instantiate()
		add_child(_weapon_instance)
		_weapon_instance.rotation = res.ROTATION
		_weapon_instance.position = res.POSITION
		_weapon_instance.scale = Vector3(res.SCALE,res.SCALE,res.SCALE)
		weapon_loaded = true
	else:
		push_warning("No model scene set for weapon.")
