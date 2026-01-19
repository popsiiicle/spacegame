class_name samgun extends pweapon

var sam ## What you just shot at
var samscene = load("res://scenes/samuel.tscn")
func leftclick():
	sam = hitscan_raycast()
	if sam != {}:
		var samuel = samscene.instantiate()
		get_tree().root.add_child(samuel)
		samuel.position = sam.position
