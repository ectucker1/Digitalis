extends Spatial

var SPARKLE_SCENE = preload("res://Core/Spells/Sparkle.tscn")
var SPELL_STATUS_SCENE = preload("res://Core/SpellStatus.tscn")

var hands

# Called when the node enters the scene tree for the first time.
func _ready():
	hands = []
	$Leap_Motion.connect("new_hand", self, "_new_hand")
	$Leap_Motion.connect("about_to_remove_hand", self, "_remove_hand")

func _new_hand(hand):
	var index = hand.find_node("Index_Distal", true, false)
	
	var sparkle = SPARKLE_SCENE.instance()
	index.add_child(sparkle)
	sparkle.global_transform.origin = index.global_transform.origin
	
	var status = SPELL_STATUS_SCENE.instance()
	hand.add_child(status)
	
	hands.append(hand)

func _remove_hand(hand):
	hands.erase(hand)

func num_hands():
	return hands.size()

func get_status(i):
	print(hands[i].get_children())
	return hands[i].find_node("Status", true, false)

func get_node_status(node):
	return node.find_node("Status", true, false)

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