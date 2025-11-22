@tool
extends pweaponhandler


@export_category("Weapon Positioner")
@export_tool_button("Load Weapon","Load") var load_weapon_button_action = load_weapon_button

var _model_instance: Node3D

func load_weapon_button():
	
	# Resource goes to in game position
	_model_instance = load_weapon(resource)
	_model_instance.position = resource.POSITION
	_model_instance.rotation = resource.ROTATION
	_model_instance.scale.x = resource.SCALE
	weapon_loaded = true


func _process(_delta):
	if weapon_loaded:
		#set scale shortcut
		var s := _model_instance.scale
		#check to make sure model scale values are uniform
		var odd_one := -1
		if s.x == s.y:
			odd_one =  0
		if s.x == s.z:
			odd_one = 1
		if s.y == s.z:
			odd_one = 2

		if odd_one >= 0:
			var new_scale = s[odd_one]
			_model_instance.scale = Vector3(new_scale,new_scale,new_scale)
		else:
			scale = s.x
			
			
	#set other variables to in game model every frame
		position = _model_instance.position
		rotation = _model_instance.rotation

var weapon_loaded := false:
	set(value):
		weapon_loaded = value
		_weapon_loaded = value

@export var _weapon_loaded := false:
	set(value):
		if weapon_loaded != _weapon_loaded:
			_weapon_loaded = weapon_loaded
@export_tool_button("Save Position","Save") var save_position_button_action = save_position

func save_position():
	pass

@export_group("Weapon Position")

#set in game model position based off sliders below
@export_custom(PROPERTY_HINT_RANGE,"-1.5,1.5,0.05,slider") var position := Vector3.ZERO:
	set(value):
		position = value
@export_custom(PROPERTY_HINT_RANGE,"-1.5,1.5,0.05,slider") var rotation := Vector3.ZERO:
	set(value):
		rotation = value
@export_range(0,3,0.05, "or_greater") var scale := 1.0:
	set(value):
		scale = float(value)

func _init():
	if not Engine.is_editor_hint():
		var error := "Turn off the weapon positioning tool before running the game."
		push_error(error)
		print(error)
