class_name PlayerManager extends Node

enum {SERVER, CLIENT}
var type: String

var playerlist: Dictionary
var playercount: int = 0

const emptyplayerinfo: Dictionary = {
	"name": "Player 0",
	"weapon": "sniper",
	"color": Color(1,1,1,1),
	"kills": 0,
	"deaths": 0
}

const weaponpath: Dictionary = {
	"sniper": "res://scenes/pweapons/psniper/psniper.tres",
	"rlauncher": "res://scenes/pweapons/prlauncher/prlauncher.tres"
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
func _on_player_join(id):
	if multiplayer.is_server(): 
		playercount = playercount + 1
		playerlist[id] = emptyplayerinfo.duplicate()
		playerlist[id]["name"] = "Player " + str(playercount)
		playerlist[id]["color"] = colorarray[playercount - 1]

		var serverplist = playerlist
		
		sync_player_list.rpc(serverplist)
	
func player_killed(deadplayer: int,killingplayer: int):
	if !multiplayer.is_server(): return
	playerlist[killingplayer]["kills"] = playerlist[killingplayer]["kills"] + 1
	playerlist[deadplayer]["deaths"] += 1
	sync_player_list.rpc(playerlist)
	
signal updateplayerlist #For visual player list
@rpc("any_peer","call_local")
func sync_player_list(serverplist):
	playerlist = serverplist
	updateplayerlist.emit()
