class_name Cooldown extends Timer

## Creates cooldown
## makes it the child of parent input and returns the timer
static func create(parent: Node):
	var newcd = Cooldown.new()
	parent.add_child(newcd)
	return newcd

func _ready():
	one_shot = true
