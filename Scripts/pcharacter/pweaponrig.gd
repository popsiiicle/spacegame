@tool

class_name pweaponrig extends Node3D

var weaponres: pweaponres

@export var _model_instance: Node3D = null

func _ready():
	weaponres = preload("res://scenes/pweapons/psniper/psniper.tres")
	loadweapon(weaponres)
	pass

func loadweapon(weapon):
	
	if weapon.SCENE:
		_model_instance = weapon.SCENE.instantiate()
		add_child(_model_instance)
		#_model_instance.transform.rotation = weaponres.ROTATION
	else:
		push_warning("No model scene set for %s" % weaponres.NAME)
