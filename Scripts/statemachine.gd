class_name StateMachine

extends Node

@export var current_state : State
var states: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#check if every child is a state
	for child in get_children():
		if child is State:
			
			#if it is, add it to the state dictionary
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State Machine Contains Incompatible Child Node")
	await owner.ready
	current_state.enter()


# forward process and physics process functions from current state to the character.  
func _process(delta):
	current_state.update(delta)
	gvars.debug.add_property("Current State",current_state,2)

func _physics_process(delta):
	current_state.physics_update(delta)


# When states transition between each other
func on_child_transition(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.exit()
			new_state.enter()
			current_state = new_state
		else:
			push_warning("New state that is being transitioned to does not exist. ")
