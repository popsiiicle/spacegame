extends Node

enum {SERVER, CLIENT}
var type: String

var playerlist: Dictionary
var playercount: int = 0

const emptyplayerinfo: Dictionary = {
	"name": "Player 0",
	"color": Color(1,1,1,1),
	"kills": 0,
	"deaths": 0
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
		gfunc.cprint(self,playerlist)

		var serverplist = playerlist
		
		updateplayerlist.emit()  #HACK: May not be necessary unless sync player list doesn't run on server
		sync_player_list.rpc(serverplist)
	

signal updateplayerlist #For visual player list
@rpc("any_peer")
func sync_player_list(serverplist):
	playerlist = serverplist
	updateplayerlist.emit()
