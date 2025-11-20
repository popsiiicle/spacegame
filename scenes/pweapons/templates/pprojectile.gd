class_name pProjectile extends RigidBody3D

@export var projspeed: float
var projdirection: Vector3
var projid: String



func _ready():
	linear_velocity = projdirection.normalized() * projspeed
