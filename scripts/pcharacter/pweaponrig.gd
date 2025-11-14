class_name pweaponrig extends pweaponhandler

var weapon_instance: Node3D = null

func _ready():
	weapon_instance = load_weapon(resource)
	
	
		
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		weapon_instance._leftclick()
