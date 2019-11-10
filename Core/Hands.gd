extends Spatial

var SPARKLE_SCENE = preload("res://Core/Spells/Sparkle.tscn")
var SPELL_STATUS_SCENE = preload("res://Core/SpellStatus.tscn")

var hands

func _ready():
	hands = []
	$Leap_Motion.connect("new_hand", self, "_new_hand")
	$Leap_Motion.connect("about_to_remove_hand", self, "_remove_hand")

# Event called when a new hand enters
func _new_hand(hand):
	# Add sparkle particles to index finger
	var index = hand.find_node("Index_Distal", true, false)
	var sparkle = SPARKLE_SCENE.instance()
	index.add_child(sparkle)
	sparkle.global_transform.origin = index.global_transform.origin
	
	# Add status tracker to hand
	var status = SPELL_STATUS_SCENE.instance()
	hand.add_child(status)
	
	# Add hand to list
	hands.append(hand)

# Event called when a hand exits
func _remove_hand(hand):
	hands.erase(hand)

# Returns the number of hands currently tracked
func num_hands():
	return hands.size()

# Gets the status node for the i-th hand
func get_status(i):
	return hands[i].find_node("Status", true, false)

# Gets the status node for the given hand
func get_node_status(node):
	return node.find_node("Status", true, false)

# Returns a list of children of the tracked hands with the given name
func get_nodes(name):
	var nodes = []
	for hand in hands:
		var node
		if name.empty():
			node = hand
		else:
			node = hand.find_node(name, true, false)
		nodes.append(node)
	return nodes

# Returns a list of positions of the parts of the tracked hands with the given name
func get_positions(name):
	var positions = []
	for hand in hands:
		var node
		if name.empty():
			node = hand
		else:
			node = hand.find_node(name, true, false)
		var pos = node.get_global_transform().origin
		positions.append(pos)
	return positions

# Returns a list of transforms of the parts of the tracked hands with the given name
func get_transforms(name):
	var transforms = []
	for hand in hands:
		var node
		if name.empty():
			node = hand
		else:
			node = hand.find_node(name, true, false)
		var transform = node.get_global_transform()
		transforms.append(transform)
	return transforms

# Returns a list of euler angles of the parts of the tracked hands with the given name
func get_eulers(name):
	var angles = []
	for hand in hands:
		var node
		if name.empty():
			node = hand
		else:
			node = hand.find_node(name, true, false)
		var euler = node.get_global_transform().basis.get_euler()
		angles.append(euler)
	return angles