@tool

class_name WeaponRig extends Node3D

var psniperres := load("res://scenes/pweapons/psniper/psniper.tres")
var prlauncherres := load("res://scenes/pweapons/prlauncher/prlauncher.tres")
@export var editorres: pweaponres
var weapon_loaded := false
var _WEAPON_INSTANCE: Node3D = null


func _ready():
	pass
	#load_weapon(psniperres)
	
## Loads the apropriate weapon to the player model
func load_weapon(res: pweaponres):
	if _WEAPON_INSTANCE:
		_WEAPON_INSTANCE.queue_free()
	if res.SCENE:
		_WEAPON_INSTANCE = res.SCENE.instantiate()
		add_child(_WEAPON_INSTANCE)
		_WEAPON_INSTANCE.rotation = res.ROTATION
		_WEAPON_INSTANCE.position = res.POSITION
		_WEAPON_INSTANCE.scale = Vector3(res.SCALE,res.SCALE,res.SCALE)
		weapon_loaded = true
	else:
		push_warning("No model scene set for weapon.")
		
