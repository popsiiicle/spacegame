extends Camera3D

##The game FOV when not scoped in
@export var defaultfov := 90.0


func _ready():
	#loads variable permanently so other scripts can reference it
	await owner.ready
	if is_multiplayer_authority():
		gvars.pcamera = self
		gfunc.cprint(self, "making player camera current, player is " + get_parent().get_parent().get_parent().get_parent().name)
		make_current()
func reset_fov():
	#resets fov when the function is called
	fov = defaultfov
