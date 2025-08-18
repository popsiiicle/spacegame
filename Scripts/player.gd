extends CharacterBody3D


#game constants
const SENS = 0.00375 ## Mouse Sensitivity
const SPEED = 5.0 ## Player speed
const JUMP_VELOCITY = 4.5 ## Player jump velocity
const THRUSTVEL = 10 ## Constant thrust velocity using WSAD keys
const TOPAIRSPEED = 30 ## At this speed, the thrusters shut off
const DASHSTRENGTH = 10 ## How strong the dash ability is
const ROTATIONSPEED = .0005 ## How fast the character rotates
var ingrav = true ##true if the user is in a gravitational field.  Used for normal controls


var dash_rdy := true ## if the dash ability is off cooldown

var dashcd := Timer.new() ## cooldown for the dash ability
#timer for dash cooldown

var touching_surface: bool = false ## if the character is touching any surface.  Used for state machine

#What happens when dash goes off cooldown
func dashcd_reset() -> void:
	dash_rdy = true

#On game start
func _ready():
	
	#initialize Dash Cooldown
	dashcd.wait_time = 1.0 # 1 second
	dashcd.one_shot = true # don't loop, run once
	dashcd.timeout.connect(dashcd_reset)
	add_child(dashcd)
	
	#initialize global variable
	gvars.player = self


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func set_gravity(new_gravity: Vector3):
	gravity = new_gravity  # Assuming `gravity` is a variable controlling movement

#Mouse and Neck Variables
@onready var cpivot := $Camera_Pivot
@onready var neck := $Camera_Pivot/Neck
@onready var camera := $Camera_Pivot/Neck/Camera3D

#Input.get_vector(), but for 3 axis.  Used for RCS movement
func get_vector3(neg_x: String, pos_x: String, neg_y: String, pos_y: String, neg_z: String, pos_z: String) -> Vector3:
	return Vector3(
		Input.get_action_strength(pos_x) - Input.get_action_strength(neg_x),
		Input.get_action_strength(pos_y) - Input.get_action_strength(neg_y),
		Input.get_action_strength(pos_z) - Input.get_action_strength(neg_z)
	).normalized()
	

#Controls Mouse Input and converts it to neck and camera rotation
func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			
			
			#controls up and down movements of the mouse, moves neck if neck is not moved to the max, rotates body if it isn't
			var neckroty = neck.rotation.y
			var msign = sign(-event.relative.x)
			if msign != 0:
				if msign * neckroty < deg_to_rad(60):
					neck.rotate_object_local(Vector3(0,1,0),-event.relative.x*SENS)
				else:
					cpivot.rotate_object_local(Vector3(0,1,0),-event.relative.x*SENS)
			
			
			#controls up and down movements of the mouse, moves camera if camera is not moved to the max, rotates body if it isn't
			var camrotx = camera.rotation.x
			msign = sign(-event.relative.y)
			if msign != 0:
				if msign * camrotx < deg_to_rad(60):
					camera.rotate_object_local(Vector3(1,0,0),-event.relative.y*SENS)
				else:
					cpivot.rotate_object_local(Vector3(1,0,0),-event.relative.y*SENS)
			
var rotv = 0 ##????

func _physics_process(delta):
	
	#debug properties
	var dashcdstr = "%.1f" % dashcd.time_left
	gvars.debug.add_property("Dash Cooldown",dashcdstr,1)
	
	gvars.debug.add_property("Touching Wall",is_on_wall(),5)
	
	#gets input direction in 3d and constrained to 2d
	var input_dir = get_vector3("left", "right", "crouch", "jump","forward","back")
	#var direction_2d = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	var direction_3d = camera.global_transform.basis * input_dir

	
	
	#dash execution
	if Input.is_action_pressed("dash") and dash_rdy == true:
		velocity = velocity + direction_3d * DASHSTRENGTH
		dash_rdy = false
		dashcd.start()
	
	#rotation
	#fix so that angular moment is conserved around body rather than camera
	var rot_input = 1 * int(Input.is_action_pressed("rotate_l")) + -1 * int(Input.is_action_pressed("rotate_r"))
	rotv = rotv + rot_input
	transform.basis = transform.basis.rotated(camera.global_transform.basis.z, ROTATIONSPEED * rotv)
	
	
	#floaty code
	if is_on_floor:
		if direction_3d:
			velocity += direction_3d*THRUSTVEL*delta
			if velocity.length() >= TOPAIRSPEED:
				velocity = velocity*(TOPAIRSPEED/velocity.length())
	
	#slides across walls (temporary)
	if is_on_wall():
		var wallnorm = get_wall_normal()
		if velocity.dot(wallnorm) < 0:
			velocity = velocity.slide(get_wall_normal())
	move_and_slide()
