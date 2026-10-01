class_name ShootableObject extends Node3D
#split into 2 classes later

@export var health: float = 100


func taken_damage(damage: float,damager):
	if !multiplayer.is_server():
		printerr("Client Healthnode recieved an input, but taken_damage should only be transmitted serverside")
	health -= damage
	sync_health.rpc(health,damager)
	#mb theres a cleaner way instead of passing the damager through 

signal destroy_object(object: Node)

signal health_changed(health)

@rpc("any_peer","call_local")
func sync_health(new_health,damager):
	health = new_health
	health_changed.emit(health)
	if health <= 0:
		gvars.playermanager.player_killed(int(get_parent().get_parent().get_name()),int(damager))
		destroy_object.emit(get_parent())
