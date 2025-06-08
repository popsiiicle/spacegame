extends PanelContainer

var property
var fps : String
@onready var property_container = %VBoxContainer

#set debug panel to not loaded on start
func _ready():
	visible=false
	add_debug_property("FPS","fps")

#toggle debug panel

func _process(delta):
	if visible:
		
		fps = "%.2f" % (1.0/delta)
		property.text = property.name + ": " + fps

func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible

#callable function to add new debug property
func add_debug_property(title : String,value):
	property = Label.new() #create new label node
	property_container.add_child(property) #adds label as a child node to vbox
	property.name = title #sets a title to the node
	property.text = property.name + value #display property text
