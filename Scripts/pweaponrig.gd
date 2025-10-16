class_name pweapon extends Node3D

@export var weaponres: pweaponres

var _model_instance: Node3D = null

func _ready():
	loadweapon()
	

func loadweapon():
	
	if weaponres:
		_model_instance = weaponres.SCENE.instantiate()
		add_child(_model_instance)
		#_model_instance.transform.position = weaponres.POSITION
	else:
		push_warning("No model_scene set for %s" % weaponres.NAME)
