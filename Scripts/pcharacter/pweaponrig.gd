@tool

class_name pweaponrig extends Node3D

var weaponres: pweaponres

@export var _model_instance: Node3D = null

func _ready():
	weaponres = load("res://scenes/pweapons/psniper/psniper.tres")
	loadweapon(weaponres)
	pass

func loadweapon(weapon):
	if weapon:
		_model_instance = weapon.SCENE.instantiate()
		add_child(_model_instance)
		_model_instance.rotation = weaponres.ROTATION
		_model_instance.position = weaponres.POSITION
		_model_instance.scale = Vector3(weaponres.SCALE,weaponres.SCALE,weaponres.SCALE)
	else:
		push_warning("No model scene set for weapon.")
		
func _process(delta):
	if Engine.is_editor_hint():
		_model_instance.rotation = weaponres.ROTATION
		_model_instance.position = weaponres.POSITION
		_model_instance.scale = Vector3(weaponres.SCALE,weaponres.SCALE,weaponres.SCALE) 
