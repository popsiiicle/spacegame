extends VBoxContainer


func _ready() -> void:
	#gvars.playermanager.updateplayerlist.connect()
	_on_update_player_list()

func _on_update_player_list():
	await get_tree().create_timer(0.5).timeout
	var playerlist: Array = gvars.playermanager.playerlist.values()
	playerlist.sort_custom(sort_by_kills)
	for playerentry in playerlist:
		PlayerEntry.create(self,playerentry)
#TODO: delete list before recreating on update, track kills and deaths


func sort_by_kills(a,b):
	return a["kills"] >= b["kills"]
