class_name psniper extends pweapon

@export var damage: float

func _leftclick_cd():
	hitscandmg(damage)
	
	#Add effects here
