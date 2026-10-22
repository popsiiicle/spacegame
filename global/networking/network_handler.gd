extends Node

const IP_ADDRESS := "localhost"
const PORT := 46985

var pscene := preload("res://scenes/pcharacter/character.tscn")
var peer: ENetMultiplayerPeer

#create server
func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	
	#Unnecessary, but will keep in case it is needed
	gfunc.cprint(self,"server started")
	
	
	#adds players when they connect
	multiplayer.peer_connected.connect(add_player)

	#adds host to lobby
	add_player(multiplayer.get_unique_id())
	


#called on host only (hopefully)
signal player_joined(id, playernode: Node3D) #HACK: won't work if there's a main menu or spectator or smth as Node3D may not exist yet
func add_player(peer_id):
	gfunc.cprint(self,"player joined (peer id: %d)" % peer_id)
	player_joined.emit(peer_id)
	spawn_deathcamera.rpc(peer_id)

#spawn player as respawning camera (only on authority)
@rpc("authority","call_local")
func spawn_deathcamera(id: int):
	DeathCamera.create(id) #spawn player as respawning camera

func spawn_player(peer_id: int) -> Node3D:
	var player = pscene.instantiate()
	player.name = str(peer_id)
	gvars.level.add_child(player,true)
	
	return player
	
	
	
#CLIENT CODE
func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
	
