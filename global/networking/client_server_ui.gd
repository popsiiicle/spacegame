extends Control

@export var level: Node3D

func _ready():
	await get_parent().get_parent().ready
	if "-server" in gvars.args:
		_on_server_pressed()
	elif "-client" in gvars.args:
		_on_client_pressed()

func _on_server_pressed():
	networkhandler.start_server()
	hide()

@onready var entryfield: String = $VBoxContainer/IPEntryField.text
var ipaddress: String:
	get():
		if entryfield == "":
			return "localhost"
		else:
			return entryfield
var port: int:
	get():
		if $VBoxContainer/PortEntryField.text == "":
			return 46985
		else:
			return int($VBoxContainer/PortEntryField.text)

func _on_client_pressed():
	networkhandler.start_client(ipaddress,port)
	hide()
