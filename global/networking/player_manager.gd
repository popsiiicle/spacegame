extends Node

enum {SERVER, CLIENT}
var type: String

var playerlist: Dictionary
var playercount: int = 0

var emptyplayerinfo: Dictionary = {
	"name": "Player 0",
	"color": 0
}



func _ready():
	networkhandler.player_joined.connect(_on_player_join)

func _on_player_join(id,_playernode):
	if multiplayer.is_server(): 
		playercount = playercount + 1
		playerlist[id]["name"] = "Player " + str(playercount)
		playerlist[id]["color"] = playercount - 1
		#TODO: set color in player.gd

	var serverplist = playerlist
	sync_player_list.rpc(serverplist)
	

@rpc("any_peer")
func sync_player_list(serverplist):
	playerlist = serverplist
	
