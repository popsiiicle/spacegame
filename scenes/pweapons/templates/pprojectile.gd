class_name pProjectile extends RigidBody3D

var projspeed := 10
var projdirection: Vector3
var projid: String



func _ready():
	linear_velocity = projdirection.normalized() * projspeed
	print(linear_velocity)
