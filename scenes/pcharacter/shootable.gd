class_name ShootableObject extends Node3D
#split into 2 classes later

@export var health: float = 100


func taken_damage(damage):
	if !multiplayer.is_server():
		printerr("Client Healthnode recieved an input, but taken_damage should only be transmitted serverside")
	health -= damage
	sync_health.rpc(health)

signal destroy_object(object)

signal health_changed(health)

@rpc("any_peer","call_local")
func sync_health(new_health):
	health = new_health
	health_changed.emit(health)
	if health <= 0:
		destroy_object.emit(get_parent())
