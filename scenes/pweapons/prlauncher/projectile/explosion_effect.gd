extends GPUParticles3D

func _ready():
	print("particle created")
	print(get_parent())
	$DetonateSound.play(0.3)
	await get_tree().create_timer(5).timeout
	queue_free()
