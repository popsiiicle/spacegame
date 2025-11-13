class_name Cooldown extends Timer

func _ready():
	one_shot = true
	
func create(caller):
	Cooldown.new()
	caller.add_child(self)
