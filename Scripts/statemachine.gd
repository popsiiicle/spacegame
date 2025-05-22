class_name StateMachine

extends Node

@export var current_state : State
var states: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State Machine Contains Incompatible Child Node")
	current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func on_child_transition(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.exit()
			new_state.enter()
			current_state = new_state
		else:
			push_warning("New state that is being transitioned to does not exist. ")
