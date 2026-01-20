extends PanelContainer

var fps : String ## Frame rate (_process per second)
var tps : String ## Tick rate of the physics engine (_physics_process per second)

## I have no idea I copied this from a youtube tutorial
@onready var property_container = %VBoxContainer

func _ready():
	## debug not visible on load
	visible=false
	
	## globally load this script
	gvars.debug = self

func _process(delta):
	if visible:
		
		# Display FPS only when visible
		fps = "%.2f" % (1.0/delta)
		add_property("FPS",fps,0)

func _physics_process(delta):
	if visible:
		
		# Display TPS only when visible
		tps = "%.2f" % (1.0/delta)
		add_property("TPS",tps,1)

func _input(event):
	# Toggles debug window when f1 is pressed
	if event.is_action_pressed("debug"):
		visible = !visible


# Function that adds properties to the debug window.  Will update every time it is ran with the same property
# add_property("Display Name",variablename, order it appears on the list)
# Higher order numbers appear lower than lower order numbers
func add_property(title: String, value, order: int):
	
	var target ## Current node depicting the property
	
	#finds if there is a current lable node for this property
	target = property_container.find_child(title,true,false)
	
	if !target: #if there isn't
		target = Label.new() #create a new one
		property_container.add_child(target) #add it as a child to vbox container
		target.name = title #change the name to the inputted title
		target.text = target.name + ": " + str(value) #update text value
		
		#if it exists and its visible
	elif visible:
		target.text = title + ": " + str(value) #update text
		property_container.move_child(target,order) #reorder property based on given order value
