class_name pProjectile extends RigidBody3D

@export var projspeed: float
var projdirection: Vector3
var projid: String

func _ready():
	## FIX, ADD FORCE LATER
	linear_velocity = projdirection.normalized() * projspeed
	
	#collision layers
	set_collision_layer_value(1,false)
	set_collision_layer_value(3,true)
	set_collision_mask_value(2,true)
	
	set_contact_monitor(true)
	max_contacts_reported = 5
	
	var on_body_entered_callable = on_body_entered
	body_entered.connect(on_body_entered_callable)

	
func on_body_entered(node):
	print("hit")
	print(node)
	self.queue_free()
