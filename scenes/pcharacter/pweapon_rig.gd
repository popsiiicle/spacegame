@warning_ignore("missing_tool")
class_name pWeaponRig extends WeaponRig



func _process(_delta: float) -> void:
	
	# Loads sniper when 1 is pressed, loads rl when 2 is pressed
	if Input.is_action_just_pressed("number_1"):
		load_weapon(psniperres)
	if Input.is_action_just_pressed("number_2"):
		load_weapon(prlauncherres)
			
		# transfers inputs to the weapon when it is loaded
	if weapon_loaded:
		if Input.is_action_just_pressed("shoot"):
			_WEAPON_INSTANCE._leftclick()
		if Input.is_action_just_pressed("secondaryfire"):
			_WEAPON_INSTANCE._rightclick()
		if Input.is_action_just_released("secondaryfire"):
			_WEAPON_INSTANCE.rightclick_release()
