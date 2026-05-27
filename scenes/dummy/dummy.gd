class_name dummy extends RigidBody3D

@onready var healthlogic: ShootableObject = $DestroyableObject

# Connects to the destroyableobject node
func _ready():
	healthlogic.destroy_object.connect(_on_destroyableobject_destroyed)
	
# Kills itself whenever the destroyable object is destroyed
func _on_destroyableobject_destroyed():
	get_parent().queue_free()
