extends Camera3D

##The game FOV when not scoped in
@export var defaultfov := 90.0


func _ready():
	#loads variable permanently so other scripts can reference it
	gvars.pcamera = self

func reset_fov():
	#resets fov when the function is called
	fov = defaultfov
