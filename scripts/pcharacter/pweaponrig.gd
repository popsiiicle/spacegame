class_name pweaponrig extends Node3D

var psniper = load("res://scenes/pweapons/psniper/psniper.tres")
var prlauncher = load("res://scenes/pweapons/prlauncher/prlauncher.tres")
var weapon_loaded := false
var _weapon_instance: Node3D = null

func _ready():
	loadweapon(psniper)
	
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
	if Input.is_action_just_pressed("number_1"):
		loadweapon(psniper)
	if Input.is_action_just_pressed("number_2"):
		loadweapon(prlauncher)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") and weapon_loaded:
		_weapon_instance._leftclick()
