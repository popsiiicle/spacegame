class_name Cooldown extends Timer


static func create(caller):
	var newcd = Cooldown.new()
	caller.add_child(newcd)
	return newcd

func _ready():
	one_shot = true
