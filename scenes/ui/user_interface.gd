extends Control

@onready var crosshair := $Crosshair
@onready var crosshairsprite := $Crosshair/Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gvars.hud = self
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
