extends Node

var debug ## for debug window stuff

signal playerready
var player: Player: ## for state machine stuff
	set(value):
		player = value
		playerready.emit()
		

var pcamera: Camera3D ## The player camera

signal level_ready
var level: Node3D:  ## The current level
	set(value):
		level = value
		level_ready.emit()


var hud: Control

var args: PackedStringArray
func _init():
	args = OS.get_cmdline_args()
