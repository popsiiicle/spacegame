extends Camera3D

func _ready():
	gvars.pcamera = self

func _physics_process(delta: float) -> void:
	gvars.debug.add_property("camera global position",global_position,40)
	gvars.debug.add_property("camera global rotation",global_rotation,41)
