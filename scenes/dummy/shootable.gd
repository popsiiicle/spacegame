class_name shootable extends Node
#split into 2 classes later

@export var health: float = 100

func _physics_process(delta):
	gvars.debug.add_property("dummyhealth",health,27)
	if Input.is_key_pressed(KEY_H):
		health -= 5
		destroy_check()

func _take_damage(damage):
	health -= damage
	destroy_check()

func destroy_check():
	if health <= 0:
		get_parent().get_parent().queue_free()
