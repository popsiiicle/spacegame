extends Node

var debug ## for debug window stuff

signal playerready
var player: Player: ## for state machine stuff
	set(value):
		player = value
		playerready.emit()
var pcamera: Camera3D ## The player camera
var level: Node3D ## The current level
var playermanager: ## The list of players and their basic information
	set(value):
		playermanager = value
		playermanager_ready.emit()
signal playermanager_ready
var hud: Control

var args: PackedStringArray

func _init():
	args = OS.get_cmdline_args()
