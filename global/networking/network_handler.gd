extends Node

const IP_ADDRESS := "localhost"
const PORT := 46985

var peer: ENetMultiplayerPeer

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	print("server started")
	print(result)
	
func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
	print("client started")
	print(result)

func _process(_delta):
	if Input.is_action_pressed("dash"):
		pass
	
		
