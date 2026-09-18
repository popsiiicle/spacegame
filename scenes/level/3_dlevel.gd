extends Node3D

@onready var playermanager: Node = $PlayerManager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gvars.level = self
