extends pProjectile

@export var explosion_particle: PackedScene
@onready var detonation_sound = $DetonateSound

func on_any_collision(_node: CollisionObject3D):
	play_collision_particle(explosion_particle)
	detonation_sound.play(0)
	queue_free()
