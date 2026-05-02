class_name shootable extends Node3D
#split into 2 classes later

@export var health: float = 100



var source: Node ## Source of Damage
signal taken_damage(dmg,source)


func _ready():
	taken_damage.connect(_on_taken_damage)
	


func _physics_process(_delta):
	gvars.debug.add_property("dummyhealth",health,27)
	if Input.is_key_pressed(KEY_H):
		health -= 5
		destroy_check()


func _on_taken_damage(damage):
	health -= damage
	destroy_check()

signal destroyed(source)
func destroy_check():
	if health <= 0:
		destroyed.emit(source)
