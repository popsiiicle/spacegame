class_name pProjectile extends RigidBody3D

var projspeed: float
var projdirection: Vector3

func _ready():
	linear_velocity = projdirection.normalized() * projspeed
