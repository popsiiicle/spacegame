class_name pweaponrig extends Node3D

@export var weaponres: pweaponres:
	set(value):
		_weaponres = value
		loadweapon(value)
var _weaponres: pweaponres

var _model_instance: Node3D = null

func _ready():
	weaponres = load("res://scenes/pweapons/psniper/psniper.tres")
	loadweapon(weaponres)
	pass

func loadweapon(weapon):
	if weapon:
		_model_instance = weapon.SCENE.instantiate()
		add_child(_model_instance)
		_model_instance.rotation = weapon.ROTATION
		_model_instance.position = weapon.POSITION
		_model_instance.scale = Vector3(weapon.SCALE,weapon.SCALE,weapon.SCALE)
	else:
		push_warning("No model scene set for weapon.")
		
