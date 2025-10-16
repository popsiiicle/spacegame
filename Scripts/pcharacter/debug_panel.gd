extends PanelContainer

var fps : String ## Frames per second the game is displaying
var tps : String ## Tick rate of the physics engine
@onready var property_container = %VBoxContainer

func _ready():
	visible=false
	
	#sets globalvars script to equal debug panel node
	gvars.debug = self
	
#toggle debug panel

#FPS
func _process(delta):
	if visible:
		fps = "%.2f" % (1.0/delta)
		add_property("FPS",fps,0)

func _physics_process(delta):
	if visible:
		tps = "%.2f" % (1.0/delta)
		add_property("TPS",tps,0.5)
func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible

func add_property(title: String, value, order):
	var target
	
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
