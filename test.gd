@tool
extends Node

@export var export_bool := false:
	set(value):
		print("changed export bool")

@export_tool_button("Zamn","CharacterBody3D") var wow = function_wow

func function_wow():
	export_bool = !export_bool

@export_tool_button("Hello", "Callable") var hello_action = hello

func hello():
	print("Hello world!")
