class_name psniper extends pweapon

@export var damage: float

func leftclick():
	hitscandmg(damage)
	LeftClickCooldown.start(1)
	#Add effects here
