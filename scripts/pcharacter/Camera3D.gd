extends Camera3D

@export var defaultfov := 90.0

func _ready():
	gvars.pcamera = self

func resetfov():
	fov = defaultfov
