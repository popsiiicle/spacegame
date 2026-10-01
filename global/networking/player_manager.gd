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

		var serverplist = playerlist
		
		sync_player_list.rpc(serverplist)
	
func player_killed(deadplayer: int,killingplayer: int):
	if !multiplayer.is_server(): return
	gfunc.cprint(self,"player killed is " + str(deadplayer) + "player killing is " + str(killingplayer))
	#gfunc.cprint(self,str(playerlist[str(deadplayer)]["deaths"]))
	playerlist[killingplayer]["kills"] = playerlist[killingplayer]["kills"] + 1
	playerlist[deadplayer]["deaths"] += 1
	sync_player_list.rpc(playerlist)
	#FIX: sometimes applies death to host instead of right player, kills always count as player 1

signal updateplayerlist #For visual player list
@rpc("any_peer","call_local")
func sync_player_list(serverplist):
	playerlist = serverplist
	updateplayerlist.emit()
