class_name PlayerMovementState
## Class that adds the PLAYER variable to the movement states for easier reference
extends State

#initializes the variable
var PLAYER: player

#sets player equal to PLAYER
func _ready() -> void:
	await owner.ready
	PLAYER = gvars.player as player
