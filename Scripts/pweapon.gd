class_name pweapon extends Node3D

@export var weapon_name: String
@export var weapon_scene: PackedScene
@export var weapon_pos: Vector3 ## The position of the weapon onscreen
@export var weapon_rot: Vector3
@export var wresource: Resource

var _model_instance: Node3D = null

func _ready():
	pass
	
func _equip_weapon() -> void:
	if weapon_scene:
		_model_instance = weapon_scene.instantiate()
		add_child(_model_instance)
		#_model_instance.transform = weapon_pos
	else:
		push_warning("No model_scene set for %s" % weapon_name)
