extends Node

const IP_ADDRESS := "2600:4041:506a:5100:1d7b:4c32:cec4:1127"
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
	
	if peer_id != 1:
		pass
		#peer.get_peer(peer_id).set_timeout(30000,30000,60000)
		#HACK
	
	player_joined.emit(peer_id)
	
	#spawns player as being dead
	spawn_deathcamera.rpc(peer_id)

#spawn player as respawning camera 
#should only run on server, and MultiplayerSpawner replicates it to clients
@rpc("any_peer","call_local")
func spawn_deathcamera(id: int):
	if !multiplayer.is_server(): return
	DeathCamera.create(id) 

#spawns player after respawn timer runs out.  runs on server only 
func spawn_player(peer_id: int) -> Node3D:
	if !multiplayer.is_server():
		printerr("spawning players should only happen on client")
		return
	
	#spawn player, set name to peer id, and add to tree
	var player = pscene.instantiate()
	player.name = str(peer_id)
	gvars.level.add_child(player,true)
	
	return player
	
	
	
#CLIENT CODE (server should worry about everything and send back a replicated deathcamera node.)
func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
