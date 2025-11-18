@tool
extends pweaponhandler


@export_category("Weapon Positioner")
@export_tool_button("Load Weapon","Load") var load_weapon_button_action = load_weapon_button
var weapon_loaded_check := false:
	set(value):
		weapon_loaded_check = true
		weapon_loaded = true
@export var weapon_loaded: bool:
	set(value):
		if !value:
			weapon_loaded = false
			weapon_loaded_check = false
@export_group("Weapon Position")
@export_custom(PROPERTY_HINT_RANGE,"-1.5,1.5,0.05,slider") var position := Vector3.ZERO:
	set(value):
		position = value
		position_changed()
@export_custom(PROPERTY_HINT_RANGE,"-1.5,1.5,0.05,slider") var rotation := Vector3.ZERO:
	set(value):
		rotation = value
		position_changed()
@export_range(0,3,0.05, "or_greater") var scale := 1.0:
	set(value):
		scale = float(value)
		position_changed()


func load_weapon_button():
	var _model_instance = load_weapon(resource)
	position = resource.POSITION
	rotation = resource.ROTATION
	scale = resource.SCALE
	weapon_loaded_check = true

func position_changed():
	if weapon_loaded:
		resource.POSITION = position
		resource.ROTATION = rotation
		resource.SCALE = scale

func _init():
	if not Engine.is_editor_hint():
		var error := "Turn off the weapon positioning tool before running the game."
		push_error(error)
		print(error)
