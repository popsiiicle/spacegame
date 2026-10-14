class_name PlayerManager extends Node

enum {SERVER, CLIENT}
var type: String

var playerlistready := false
var playerlist: Dictionary:
	set(value):
		playerlist = value
		playerlistready = true
	get:
		if playerlist == {} and !multiplayer.is_server():
			request_playerlist_sync.rpc()
			await updateplayerlist
			return playerlist
		else:
			return playerlist
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


func _enter_tree():
	networkhandler.player_joined.connect(_on_player_join)
	if multiplayer.is_server():
		set_multiplayer_authority(multiplayer.get_unique_id())
	else: 
		request_playerlist_sync.rpc()


signal updateplayerlist #For visual player list
@rpc("any_peer","call_remote")
func sync_player_list(serverlist):
	playerlist = serverlist
	updateplayerlist.emit()

##SERVER CODE ONLY BELOW
@rpc("authority","call_local")
func request_playerlist_sync():
	if !multiplayer.is_server(): return #HACK: authority shouldn't run on client anyway but this should work too with zero problems
	sync_player_list.rpc(playerlist)

func _on_player_join(id):
	if multiplayer.is_server(): 
		playercount = playercount + 1
		playerlist[id] = emptyplayerinfo.duplicate()
		playerlist[id]["name"] = "Player " + str(playercount)
		playerlist[id]["color"] = colorarray[playercount - 1]
		
		sync_player_list.rpc(playerlist)
	
func player_killed(deadplayer: int,killingplayer: int):
	if !multiplayer.is_server(): return
	playerlist[killingplayer]["kills"] = playerlist[killingplayer]["kills"] + 1
	playerlist[deadplayer]["deaths"] += 1
	sync_player_list.rpc(playerlist)
	
