extends Control

@onready var scopecontainer := get_parent()
@onready var lens := $Lens

func _ready():
	resize()
	get_viewport().size_changed.connect(on_size_changed)

func on_size_changed():
	resize()

func resize():
	print(scopecontainer.size.y)
	lens.texture.height = scopecontainer.size.y
	lens.texture.width = lens.texture.get_height()
