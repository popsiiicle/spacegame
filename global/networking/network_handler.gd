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
	gfunc.cprint(self,"server started")
	#adds players when they connect
	multiplayer.peer_connected.connect(add_player)

	#adds host to lobby
	add_player(multiplayer.get_unique_id())
	
func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
	gfunc.cprint(self,"client started (%s)" % str(result))

func _process(_delta):
	if Input.is_action_pressed("dash"):
		pass

signal player_joined(id)
func add_player(peer_id):
	gfunc.cprint(self,"player joined (peer id: %d)" % peer_id)
	var player = pscene.instantiate()
	player.name = str(peer_id)
	gvars.level.add_child(player)
	player_joined.emit(peer_id)
