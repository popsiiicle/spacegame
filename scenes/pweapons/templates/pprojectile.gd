class_name pProjectile extends RigidBody3D

@export var projspeed: float
@export var projlifespan := 5.0
var projdirection: Vector3
var projid: String

func _ready():
	## FIX, ADD FORCE LATER
	linear_velocity = projdirection.normalized() * projspeed
	
	#collision layers
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(3,true)
	set_collision_mask_value(2,true)
	set_collision_mask_value(1,true)
	set_contact_monitor(true)
	max_contacts_reported = 5
	
	var on_body_entered_callable = on_body_entered
	body_entered.connect(on_body_entered_callable)
	
	#check if this is actually clean
	await get_tree().create_timer(projlifespan).timeout
	queue_free()
	
func on_hit(_node: CollisionObject3D,_target: shootable):
	pass
func on_miss(_node: CollisionObject3D):
	pass
func on_any_collision(_node: CollisionObject3D):
	pass
	
func on_body_entered(node):
	
	#very jank, correct later (check for mask instead or smth)
	var target = node.get_parent()
	if target is shootable:
		print("hit")
		on_hit(node,target)
		target.taken_damage.emit(100)
	else:
		print("miss")
		on_miss(node)
	on_any_collision(node)
	
	#splash code here
func play_collision_particle(particle: PackedScene) -> void:
	print("unpacking scene")
	var PARTICLE = particle.instantiate()
	get_tree().get_root().add_child(PARTICLE)
	PARTICLE.position = position
	PARTICLE.rotation = rotation
	PARTICLE.emitting = true
