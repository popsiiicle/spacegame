extends Camera3D

@export var defaultfov := 90.0

func _ready():
	gvars.pcamera = self

func _physics_process(delta: float) -> void:
	gvars.debug.add_property("camera global position",global_position,40)
	gvars.debug.add_property("camera global rotation",global_rotation,41)
func resetfov():
	fov = defaultfov
