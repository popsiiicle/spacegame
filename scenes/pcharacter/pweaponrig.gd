@tool

class_name pweaponrig extends Node3D

var psniperres := load("res://scenes/pweapons/psniper/psniper.tres")
var prlauncherres := load("res://scenes/pweapons/prlauncher/prlauncher.tres")
@export var editorres: pweaponres
var weapon_loaded := false
var _WEAPON_INSTANCE: Node3D = null


func _ready():
	load_weapon(psniperres)
	
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
		
func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint(): return
	if !is_multiplayer_authority(): return
	
	
	# Loads sniper when 1 is pressed, loads rl when 2 is pressed
	if Input.is_action_just_pressed("number_1"):
		load_weapon(psniperres)
	if Input.is_action_just_pressed("number_2"):
		load_weapon(prlauncherres)
		
	# transfers inputs to the weapon when it is loaded
	if weapon_loaded:
		if Input.is_action_just_pressed("shoot"):
			_WEAPON_INSTANCE._leftclick()
		if Input.is_action_just_pressed("secondaryfire"):
			_WEAPON_INSTANCE._rightclick()
		if Input.is_action_just_released("secondaryfire"):
			_WEAPON_INSTANCE.rightclick_release()
