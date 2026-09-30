class_name PlayerEntry extends HBoxContainer

@onready var playername: String = $PlayerName.text
@onready var kills: String = $Kills.text
@onready var deaths: String = $Deaths.text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#gvars.playermanager.updateplayerlist.connect()
	_on_update_player_list()

func _on_update_player_list():
	var playerlist: Array = gvars.playerlist.values()
	playerlist.sort_custom(sort_by_kills)
	for playerentry in playerlist:
		pass

func sort_by_kills(a,b):
	return a["kills"] >= b["kills"]
