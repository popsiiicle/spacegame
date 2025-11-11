class_name pweaponrig extends Node3D

@export var resource: pweaponres
var _weapon_instance: Node3D = null

func _ready():
	loadweapon(resource)
	
func loadweapon(res):
	if res:
		_weapon_instance = res.SCENE.instantiate()
		add_child(_weapon_instance)
		_weapon_instance.rotation = res.ROTATION
		_weapon_instance.position = res.POSITION
		_weapon_instance.scale = Vector3(res.SCALE,res.SCALE,res.SCALE)
	else:
		push_warning("No model scene set for weapon.")
		
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		_weapon_instance._leftclick_cd()
