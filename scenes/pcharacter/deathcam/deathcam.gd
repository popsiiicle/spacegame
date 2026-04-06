class_name DeathCamera extends Camera3D


func _enter_tree() -> void:
	position = gvars.pcamera.position
	rotation = gvars.pcamera.rotation
	gfunc.cprint(gvars.player,"Creating death cam as " + str(multiplayer.get_unique_id()))
	make_current()
