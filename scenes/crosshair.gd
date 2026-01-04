extends Sprite2D

func ready():
	get_viewport().size_changed.connect(_viewport_size_changed)
	
func _viewport_size_changed():
	print("maximize")
	

var janktimer: Cooldown = Cooldown.create(self)
func _process(_delta: float) -> void:
	if janktimer.is_stopped():
		position = get_viewport().size / 2
		janktimer.start(1)
	
