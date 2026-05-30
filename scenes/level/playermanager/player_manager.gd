extends Node

var playerlist: Dictionary
var playercount: int = 0

func _ready():
	networkhandler.player_joined.connect(_on_player_join)

func _on_player_join(id):
	if !multiplayer.is_server(): return
	playercount += 1
	playerlist[id] = "Player " + str(playercount)
	var serverplist = playerlist
	sync_player_list.rpc(serverplist)
	
@rpc("any_peer")
func sync_player_list(serverplist):
	playerlist = serverplist
	
