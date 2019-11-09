extends Spatial

var hands

# Called when the node enters the scene tree for the first time.
func _ready():
	hands = []
	$Leap_Motion.connect("new_hand", self, "_new_hand")
	$Leap_Motion.connect("about_to_remove_hand", self, "_remove_hand")

func _new_hand(hand):
	hands.append(hand)

func _remove_hand(hand):
	hands.erase(hand)

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

func get_euler(name):
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