@tool

class_name pweaponrig extends Node3D

var psniperres := load("res://scenes/pweapons/psniper/psniper.tres")
var prlauncherres := load("res://scenes/pweapons/prlauncher/prlauncher.tres")
@export var editorres: pweaponres
var weapon_loaded := false
var _weapon_instance: Node3D = null

func _ready():
	loadweapon(psniperres)
	
func loadweapon(res):
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
		
func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint():
		#loadweapon(editorres)
		pass
	else:
		if Input.is_action_just_pressed("number_1"):
			loadweapon(psniperres)
		if Input.is_action_just_pressed("number_2"):
			loadweapon(prlauncherres)
		if Input.is_action_just_pressed("shoot") and weapon_loaded:
			_weapon_instance._leftclick()
	
func _physics_process(_delta):
	pass
	
	
