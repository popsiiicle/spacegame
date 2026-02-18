extends Camera3D

##The game FOV when not scoped in
@export var defaultfov := 90.0


func _ready():
	#loads variable permanently so other scripts can reference it
	await owner.ready
	gvars.pcamera = self
	if is_multiplayer_authority():
		gfunc.cprint(self,"making camera current")
		make_current()
func reset_fov():
	#resets fov when the function is called
	fov = defaultfov
