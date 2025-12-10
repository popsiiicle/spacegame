class_name pweaponrig extends Node3D

@export var resource: pweaponres

var weapon_instance: Node3D = null

func load_weapon(res) -> Node3D:
	var _weapon_instance = res.SCENE.instantiate()
	add_child(_weapon_instance)
	_weapon_instance.rotation = res.ROTATION
	_weapon_instance.position = res.POSITION
	_weapon_instance.scale = Vector3(res.SCALE,res.SCALE,res.SCALE)
	return _weapon_instance

func _ready():
	weapon_instance = load_weapon(resource)
	
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("shoot"):
		weapon_instance._leftclick()
