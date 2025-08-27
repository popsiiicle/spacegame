class_name PlayerMovementState
extends State

var PLAYER: player

func _ready() -> void:
	await owner.ready
	PLAYER = owner as player

func _process(delta: float) -> void:
	pass

