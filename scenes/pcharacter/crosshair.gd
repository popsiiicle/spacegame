extends Sprite2D

#connect to viewport size change signal
func _ready():
	get_viewport().size_changed.connect(_viewport_size_changed)

#recenter in screen when viewport size is changed
func _viewport_size_changed():
	position = get_viewport().size / 2
	
