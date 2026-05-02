class_name pweapon extends Node3D
## Abstract class for all weapons.  Contains tools for hitscan, projectiles, and inputs


@onready var camera: Camera3D = get_parent().get_parent()
const MAX_RANGE = 1000

## Casts a ray from the camera and returns the first object it hits. 
## Use for custom effects: hitscan_damage() is better suited for dealing damage with hitscan
func hitscan_raycast() -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var screencenter = get_viewport().size / 2
	var origin = camera.project_ray_origin(screencenter)
	var end = origin + camera.project_ray_normal(screencenter) * MAX_RANGE
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	return result


# hitscan_damage vars
var targethbox: Node3D
var target: Node
var healthnode: Node
var hitscaninfo: Dictionary

## Performs hitscan_raycast(), finds if whatever is shot is damagable, and then damages the object if it is

func hitscan_damage(damage: float):
	
	hitscaninfo = hitscan_raycast()
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


## Spawns a projectile from the launchpoint towards the projdirection.  Speed is determined in projectile code
func spawn_projectile(projpackedscene: PackedScene,projdirection: Vector3, launchpoint: Node3D, projowner: Node3D) -> void:
	if projpackedscene is not PackedScene:
		push_error("projectile scene invalid")
	else:
		var PROJ = projpackedscene.instantiate()
		PROJ.projdirection = projdirection
		
		#adds to root, adds to scene tree later
		get_tree().get_current_scene().add_child(PROJ)
		PROJ.projowner = projowner
		PROJ.position = launchpoint.global_position
		PROJ.rotation = launchpoint.global_rotation


## Launches emission particle from weapon
func path_particle(particlescene: PackedScene,startpoint: Node3D):
	var PARTICLE = particlescene.instantiate()
	get_tree().get_current_scene().add_child(PARTICLE)
	PARTICLE.position = startpoint.global_position
	PARTICLE.rotation = camera.global_rotation
	
	
# Cooldowns for shots
var LeftClickCooldown: Cooldown = Cooldown.create(self) ## Cooldown for leftclick()
var RightClickCooldown: Cooldown = Cooldown.create(self) ## Cooldown for rightclick()

func leftclick():
	pass

@rpc("any_peer","call_local","reliable") 
func _leftclick():
	if LeftClickCooldown.is_stopped():
		leftclick()

@rpc("any_peer","call_local","reliable")
func _rightclick():
	if RightClickCooldown.is_stopped():
		rightclick()

func rightclick():
	pass

@rpc("any_peer","call_local","reliable")
func rightclick_release():
	pass
