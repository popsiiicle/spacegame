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
	
func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer

#called on host only (hopefully)
signal player_joined(id, playernode: Node3D) #HACK: won't work if there's a main menu or spectator or smth as Node3D may not exist yet
func add_player(peer_id):
	gfunc.cprint(self,"player joined (peer id: %d)" % peer_id)
	player_joined.emit(peer_id)
	DeathCamera.create(peer_id) #spawn player as respawning camera
	gfunc.cprint(self,"sending player join")


@rpc("any_peer","call_local")
func spawn_player(peer_id: int) -> Node3D:
	var player = pscene.instantiate()
	player.name = str(peer_id)
	gvars.level.add_child(player)
	
	return player
	
