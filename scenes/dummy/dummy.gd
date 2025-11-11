class_name dummy extends RigidBody3D

@onready var healthlogic: shootable = $DestroyableObject

func _ready():
	healthlogic.destroyed.connect(_on_destroyableobject_destroyed)
	
func _on_destroyableobject_destroyed():
	get_parent().queue_free()
