@tool
extends pweaponhandler


@export_category("Weapon Positioner")
@export_tool_button("Load Weapon","Load") var load_weapon_button_action = load_weapon_button
@export var weapon_loaded := true
@export_group("Weapon Position")
@export_custom(PROPERTY_HINT_RANGE,"-1.5,1.5,0.05,slider") var position := Vector3.ZERO
@export_custom(PROPERTY_HINT_RANGE,"-1.5,1.5,0.05,slider") var rotation := Vector3.ZERO
@export_range(0,3,0.05, "or_greater") var scale := 1.0


func load_weapon_button():
	var _model_instance = load_weapon(resource)
