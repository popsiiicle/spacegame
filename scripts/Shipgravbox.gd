extends Area3D

# @export var gravity_direction: Vector3 = Vector3.DOWN
@export var gravity_strength: float = 9.8

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  # Make sure the player is in a defined group
		body.set_gravity(gravity_direction * gravity_strength)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
