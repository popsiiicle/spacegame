class_name pProjectile extends RigidBody3D

@export var projspeed: float ## Speed of Projectile
@export var projlifespan := 5.0 ## Time before the projectile is deleted
@export var direct_hit_damage := 100.0
var projdirection: Vector3 ## Direction in which the Projectile will be initially launched

func _ready():
	# Launches projectile (FIX LATER)
	linear_velocity = projdirection.normalized() * projspeed
	
	#set collision layers
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(3,true)
	set_collision_mask_value(2,true)
	set_collision_mask_value(1,true)
	set_contact_monitor(true)
	max_contacts_reported = 5
	
	# connect with signal for entering body
	var on_body_entered_callable = on_body_entered
	body_entered.connect(on_body_entered_callable)
	
	# Wait for lifetime then delete self
	await get_tree().create_timer(projlifespan).timeout
	queue_free()


## called on hit with a player hurtbox
func on_hit(_node: CollisionObject3D,_target: shootable):
	pass
	
## called on hit for anything other than a player hurtbox
func on_miss(_node: CollisionObject3D):
	pass
	
## called on hit of any collison
func on_any_collision(_node: CollisionObject3D):
	pass
	
func on_body_entered(node):
	
	#very jank, correct later (check for mask instead or smth)
	var target = node.get_parent()
	if target is shootable:
		on_hit(node,target)
		target.taken_damage.emit(direct_hit_damage)
	else:
		on_miss(node)
	on_any_collision(node)

## spawns the particle scene whenever called
func play_collision_particle(particle: PackedScene) -> void:
	var PARTICLE = particle.instantiate()
	get_tree().get_root().add_child(PARTICLE)
	PARTICLE.position = position
	PARTICLE.rotation = rotation
	PARTICLE.emitting = true
