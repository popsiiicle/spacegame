class_name Player
extends CharacterBody3D

#movement constants
const SPEED = 5.0 ## Player speed
const JUMP_VELOCITY = 4.5 ## Player jump velocity
const DASHSTRENGTH = 20 ## How strong the dash ability is

#camera variables
const UNSCOPED_SENS = 0.001 ## Mouse sensitivity
const SCOPED_SENS_MULTIPLIER = 0.31
var sensitivity: float
const ROTATION_SPEED = 0.01 ## How fast the character rotates
var rotcameramod: bool ##Whether the rotation modifier for the camera is currently being held down
var neckroty: float ##The current y rotation of the neck node
var camrotx: float ##The current x rotation of the camera node
var msign: int ##The sign of left right or up down mouse movement
var direction_3d = Vector3(0,0,0) ##Direction of input in local coordinates of the camera

#dash ability constants
var DashCD: Cooldown = Cooldown.create(self) ## cooldown for the dash ability
var dashdirection: Vector3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func set_gravity(new_gravity: Vector3):
	gravity = new_gravity  # Assuming `gravity` is a variable controlling movement

#Pivot and Neck Node Variables
@onready var cpivot := $CameraPivot
@onready var neck := $CameraPivot/Neck
@onready var camera := $CameraPivot/Neck/Camera3D

@export var mesh: MeshInstance3D
static var playernumber := 0
static var colorarray: Array[Color] = [
	Color(0.1,0.1,1,1),
	Color(1,0,0,1),
	Color(0,1,0,1),
	Color(1,1,0,1)
]

static func set_color(localmeshinstance:MeshInstance3D):
	localmeshinstance.mesh.material.albedo_color = colorarray[playernumber]
	playernumber += 1
	


func _enter_tree():
	set_multiplayer_authority(int(get_owner().name),true)


#On game start
func _ready():
	#load player as global variable
	if is_multiplayer_authority():
		gvars.player = self
		gvars.debug.add_property("player id",get_owner().name,50)
	
	#set player color
	set_color(mesh)
	
	# connect signals
	healthlogic.destroy_object.connect(_on_destroyableobject_destroyed) #object destroyed signal


@onready var healthlogic: ShootableObject = $DestroyableObject ## health logic node

# Kills itself when health is 0 is recieved
func _on_destroyableobject_destroyed():
	get_parent().queue_free()
	

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
			if !is_multiplayer_authority(): return
			if gvars.pcamera.fov < 90:
				sensitivity = SCOPED_SENS_MULTIPLIER * UNSCOPED_SENS
			else:
				sensitivity = UNSCOPED_SENS
			
			#controls up and down movements of the mouse, moves neck if neck is not moved to the max, rotates body if it isn't
			rotcameramod = Input.is_action_pressed("rotate")
			neckroty = neck.rotation.y
			msign = sign(-event.relative.x)
			if msign != 0 and !rotcameramod:
				if msign * neckroty < deg_to_rad(60):
					neck.rotate_object_local(Vector3(0,1,0),-event.relative.x*sensitivity)
				else:
					cpivot.rotate_object_local(Vector3(0,1,0),-event.relative.x*sensitivity)
			
			
			#controls left and right movements of the mouse, moves camera if camera is not moved to the max, rotates body if it isn't
			camrotx = camera.rotation.x
			msign = sign(-event.relative.y)
			
			#Rotate camera instead of yaw when the rotate button is held down
			if msign != 0 and rotcameramod:
				transform.basis = transform.basis.rotated(camera.global_transform.basis.z, event.relative.x * ROTATION_SPEED)
			else:
				if msign * camrotx < deg_to_rad(60):
					camera.rotate_object_local(Vector3(1,0,0),-event.relative.y*sensitivity)
				else:
					cpivot.rotate_object_local(Vector3(1,0,0),-event.relative.y*sensitivity)
			

func _physics_process(_delta):
	
	if !is_multiplayer_authority(): return
	
	#adds variables to debug panels
	var dashcdstr = "%.1f" % DashCD.time_left
	gvars.debug.add_property("Dash Cooldown",dashcdstr,1)
	gvars.debug.add_property("Touching Wall",is_on_wall(),5)
	
	
	#gets input direction in 3d and constrains it to 2d
	var input_dir = get_vector3("left", "right", "crouch", "jump","forward","back")

	#var direction_2d = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	direction_3d = camera.global_transform.basis * input_dir

	
	
	#dash execution
	if Input.is_action_pressed("dash") and DashCD.is_stopped() and is_multiplayer_authority():
		if direction_3d == Vector3.FORWARD or direction_3d == Vector3.ZERO:
			dashdirection = - gvars.pcamera.global_basis.z
		else:
			dashdirection = direction_3d
		velocity = velocity + dashdirection * DASHSTRENGTH
		DashCD.start()
	
	#rotation
	#fix so that angular moment is conserved around body rather than camera
	#var rot_input = 1 * int(Input.is_action_pressed("rotate_l")) + -1 * int(Input.is_action_pressed("rotate_r"))
	#rotv = rotv + rot_input
	#transform.basis = transform.basis.rotated(camera.global_transform.basis.z, ROTATIONSPEED * rotv)
	
	#update from spacestate
	# idk what this was
	#
	#
	
	#slides across walls (temporary)
	move_and_slide()
