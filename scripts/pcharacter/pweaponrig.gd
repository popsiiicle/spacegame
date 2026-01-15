extends WeaponLoader

var psniper = load("res://scenes/pweapons/psniper/psniper.tres")
var prlauncher = load("res://scenes/pweapons/prlauncher/prlauncher.tres")
var weapon_loaded := false
var _weapon_instance: Node3D = null

func _ready():
	load_weapon(psniper)
	

		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("number_1"):
		load_weapon(psniper)
	if Input.is_action_just_pressed("number_2"):
		load_weapon(prlauncher)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") and weapon_loaded:
		_weapon_instance._leftclick()
