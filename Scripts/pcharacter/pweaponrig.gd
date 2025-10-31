class_name pweaponrig extends Node3D

@export var weapon: pweapon
@export var resource: pweaponres
var _weapon_instance: Node3D = null

func _ready():
	loadweapon(resource)
	
func loadweapon(resource):
	if resource:
		_weapon_instance = resource.SCENE.instantiate()
		add_child(_weapon_instance)
		_weapon_instance.rotation = resource.ROTATION
		_weapon_instance.position = resource.POSITION
		_weapon_instance.scale = Vector3(resource.SCALE,resource.SCALE,resource.SCALE)
	else:
		push_warning("No model scene set for weapon.")
		
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		pass
	pass
