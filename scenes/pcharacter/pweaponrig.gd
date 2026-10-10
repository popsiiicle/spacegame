@tool

class_name pweaponrig extends Node3D

var weaponresource: pweaponres ## Weapon Resource that gets loaded in the load_weapon function
@export var editorres: pweaponres ## weapon resource that is loaded in the editor
var _WEAPON_INSTANCE: Node3D ## The weapon node
var weapon_loaded := false ## Whether a weapon is currently loaded


func _ready():
	
	#loads the sniper rifle on game load
	if Engine.is_editor_hint():
		load_weapon(PlayerManager.weaponpath["sniper"])
	else:
		var selected_weapon = gvars.playermanager.playerlist[get_multiplayer_authority()]["weapon"]
		load_weapon(PlayerManager.weaponpath[selected_weapon])
		gfunc.cprint(self,"loading weapon")


## Loads the apropriate weapon to the player model from a resource
@rpc("any_peer","call_local","reliable")
func load_weapon(weapon_path: String):
	# Load resource
	weaponresource = load(weapon_path)
	
	# Delete current weapon instance if there is one
	if _WEAPON_INSTANCE:
		_WEAPON_INSTANCE.queue_free()
	
	# Loads the weapon scene from the resource
	if weaponresource.SCENE:
		_WEAPON_INSTANCE = weaponresource.SCENE.instantiate()
		add_child(_WEAPON_INSTANCE)
		
		#adjusts the weapon position from the resource
		_WEAPON_INSTANCE.rotation = weaponresource.ROTATION
		_WEAPON_INSTANCE.position = weaponresource.POSITION
		_WEAPON_INSTANCE.scale = Vector3(weaponresource.SCALE,weaponresource.SCALE,weaponresource.SCALE)
		weapon_loaded = true
	else:
		push_warning("No model scene set for weapon.")
		
func _process(_delta: float) -> void:
	
	# Run only in game for the multiplayer authority
	if Engine.is_editor_hint(): return
	if !is_multiplayer_authority(): return
	
	
	# Loads sniper when 1 is pressed, loads rocket launcher when 2 is pressed
	if gvars.args.has("-dev"):
		
		#lets devs swap weapons in game
		if Input.is_action_just_pressed("number_1"):
			load_weapon.rpc(PlayerManager.weaponpath["sniper"])
		if Input.is_action_just_pressed("number_2"):
			load_weapon.rpc(PlayerManager.weaponpath["rlauncher"])
		
	# transfers inputs to the weapon when it is loaded
	if weapon_loaded:
		if Input.is_action_just_pressed("shoot"):
			_WEAPON_INSTANCE._leftclick.rpc()
		if Input.is_action_just_pressed("secondaryfire"):
			_WEAPON_INSTANCE._rightclick.rpc()
		if Input.is_action_just_released("secondaryfire"):
			_WEAPON_INSTANCE.rightclick_release.rpc()
