extends Node

enum {SERVER, CLIENT}
var type: String

var playerlist: Dictionary
var playercount: int = 0

const emptyplayerinfo: Dictionary = {
	"name": "Player 0",
	"color": Color(1,1,1,1)
}

static var colorarray: Array[Color] = [
	Color(0.1,0.1,1,1),
	Color(1,0,0,1),
	Color(0,1,0,1),
	Color(1,1,0,1)
]

func _ready():
	gvars.playermanager = self
	networkhandler.player_joined.connect(_on_player_join)
func _on_player_join(id,_playernode):
	if multiplayer.is_server(): 
		playercount = playercount + 1
		playerlist[id] = emptyplayerinfo.duplicate()
		playerlist[id]["name"] = "Player " + str(playercount)
		playerlist[id]["color"] = colorarray[playercount - 1]
		#TODO: set color in player.gd
		gfunc.cprint(self,playerlist)

		var serverplist = playerlist
		sync_player_list.rpc(serverplist)
	

@rpc("any_peer")
func sync_player_list(serverplist):
	playerlist = serverplist
	
