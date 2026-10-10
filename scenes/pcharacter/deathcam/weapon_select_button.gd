class_name WeaponSelectButton extends Button

@export var weapon: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_theme_color_override("icon_hover_color", Color("ffff6d"))
	toggle_mode = true

func _pressed() -> void:
	gvars.playermanager.playerlist[multiplayer.get_peer_id()]["weapon"] = weapon
