extends VBoxContainer

var playerlist: Array

func _ready() -> void:
	await gvars.playermanager_ready
	gvars.playermanager.updateplayerlist.connect(_on_update_player_list)
	_on_update_player_list()

func _on_update_player_list():
	#removes all current players from list
	for child in get_children():
		child.queue_free()
	
	#puts playlist in dictionary from array, and sorts it by kills
	playerlist = gvars.playermanager.playerlist.values()
	playerlist.sort_custom(sort_by_kills)
	
	#add each player in order
	for playerentry in playerlist:
		PlayerEntry.create(self,playerentry)

func sort_by_kills(a,b):
	return a["kills"] >= b["kills"]
