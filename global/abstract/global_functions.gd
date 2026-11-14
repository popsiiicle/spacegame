class_name gfunc

static func cprint(node: Node,printstring):
	print("<" + str(node.multiplayer.get_unique_id()) + ">: " + str(printstring))

static func onlypos(number: float):
	return float(number > 0) * number
