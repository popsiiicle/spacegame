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



# CLEAN UP CODE
var targethbox: Node3D
var target: Node
var healthnode: Node
var hitscaninfo: Dictionary
func hitscandmg(damage: float):
	hitscaninfo = hitscanraycast()
	if hitscaninfo != {}:
		target = hitscaninfo.collider
		if target is CollisionObject3D:
			if target.get_collision_layer_value(2) == true:
				healthnode = target.get_parent()
				if healthnode is shootable:
					healthnode.taken_damage.emit(damage)
					#add error message later if signal is not recieved
				else:
					push_error("CollisionObject (%s) is not a child of a DestroyableObject (%s), but has a collision mask of 2." % [target,healthnode])
		else:
			push_error("Attacked hitbox is the child of %s, which is not a CollisionBody3D." % [target])


func _leftclick_cd():
	pass

func rightclick():
	pass
