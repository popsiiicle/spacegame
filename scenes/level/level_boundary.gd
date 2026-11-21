class_name OobZone extends Area3D

var playersoob: Array[Player] ##Array of players outside of the map (out of bounds)
const ACCELSTRENGTH := 100 ##Strength of Acceleration back towards the map
var accel: Vector3 ##Acceleration direction of OobZone

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	body_exited.connect(_on_body_exited)
	body_entered.connect(_on_body_entered)
func _on_body_exited(player: Player):
	playersoob.append(player)
	
func _physics_process(delta: float) -> void:
	if playersoob == null: return
	for player in playersoob:
		#FIX gotta get this not spam errors
		if !is_instance_valid(player):
			playersoob.erase(player)
		else:
			accel =  ACCELSTRENGTH * player.global_position.direction_to(self.global_position)
			player.velocity += accel*delta
			gvars.debug.add_property("Players Out of Bounds", accel, 700)


func _on_body_entered(player: Player):
	playersoob.erase(player)
