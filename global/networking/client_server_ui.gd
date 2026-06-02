extends Control

@export var level: Node3D
@onready var ipaddtextbox = $TextEdit

func _ready():
	await get_parent().get_parent().ready
	if "-server" in gvars.args:
		_on_server_pressed()
	elif "-client" in gvars.args:
		_on_client_pressed()

func _on_server_pressed():
	networkhandler.start_server()
	hide()

func _on_client_pressed():
	networkhandler.start_client(ipaddtextbox.text)
	hide()
