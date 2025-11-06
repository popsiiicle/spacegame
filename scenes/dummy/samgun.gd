class_name samgun extends pweapon

var target ## What you just shot at
var samscene = load("res://scenes/samuel.tscn")
func leftclick():
	target = hitscanraycast()
	if target != {}:
		var samuel = samscene.instantiate()
		get_tree().root.add_child(samuel)
		samuel.position = target.position
