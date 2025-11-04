class_name pweapon extends Node3D



# Tools

##tool to create hitscan shots
const MAX_RANGE = 1000
func hitscanraycast():
	var space_state = get_world_3d().direct_space_state
	var camera: Camera3D = gvars.pcamera
	var screencenter = get_viewport().size / 2
	var origin = camera.project_ray_origin(screencenter)
	var end = origin + camera.project_ray_normal(screencenter) * MAX_RANGE
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	return result

func leftclick():
	pass

func rightclick():
	pass
