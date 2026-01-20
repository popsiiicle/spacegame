extends GPUParticles3D


func _ready():
	#play collison sound on creation and then timeout
	$DetonateSound.play(0.3)
	await get_tree().create_timer(5).timeout
	queue_free()
