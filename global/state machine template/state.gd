class_name State

extends Node

# signal for transitioning between states
@warning_ignore("unused_signal")
signal transition(new_state_name: StringName)

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
