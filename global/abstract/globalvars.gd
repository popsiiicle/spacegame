extends Node

var debug ## for debug window stuff
var player ## for state machine stuff
var pcamera ## The player camera
var level ## The current level
var args 

func _init():
	args = OS.get_cmdline_args()
