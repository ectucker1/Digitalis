extends Spatial

const MIN_PALM_ANGLE = 0.4

const LIGHTNING_SPELL = 3

#var console
var hands
var crackle
var lighting

func _ready():
	hands = get_parent().get_node("Hands")
	#console = get_parent().find_node("Console", true, false)
	lighting = get_node("Effect")
	crackle = get_parent().get_node("Crackle")

# Returns a list of two potential hands for lightning from the set of active hands
func _pick_hands(choices):
	var hands = []
	for choice in choices:
		# Build list initially
		if hands.size() < 2:
			hands.append(choice)
		else:
			# Get distances from orgin
			var origin_length_1 = hands[0].global_transform.origin.length()
			var origin_length_2 = hands[1].global_transform.origin.length()
			var origin_length_choice = choice.global_transform.origin.length()
			# Keep the hands which are closest to the orign
			if origin_length_1 > origin_length_2:
				if origin_length_1 > origin_length_choice:
					hands[0] = choice
			elif origin_length_2 > origin_length_1:
				if origin_length_2 > origin_length_choice:
					hands[1] = choice
	
	# Swap hands so that left hand is first in list
	if hands.size() == 2:
		if hands[0].global_transform.origin.x > hands[1].global_transform.origin.x:
			var temp = hands[0]
			hands[0] = hands[1]
			hands[1] = temp
	
	return hands

# Lightning control process
func _process(delta):
	# Select the best hands
	var hand_nodes = _pick_hands(hands.get_nodes(""))
	
	# Hide effect by default
	lighting.hide()
	
	var crackling = false
	# If there are two valid hands
	if hand_nodes.size() == 2:
		# Get facing direction of both hands
		var dir1 = hand_nodes[0].global_transform.basis.z 
		var dir2 = hand_nodes[1].global_transform.basis.z
		
		# Calculate angle between facing directions
		var angle = acos(dir1.dot(dir2) / dir1.length() / dir2.length())
		
		# If angle is large enoguh
		if angle > MIN_PALM_ANGLE:
			# Get position of both hands
			var pos1 = hand_nodes[0].global_transform.origin
			var pos2 = hand_nodes[1].global_transform.origin
			
			# Scale to distance between hands
			var scale = (pos1 - pos2).length()
			
			# Move lightning to first hand and rotate to hit second
			lighting.look_at_from_position(pos1, pos2, Vector3(0, 1, 0))
			# Scale lightning to distance between hands
			lighting.scale = Vector3(scale, scale, scale)
			# Show lightning
			lighting.show()
			
			# Flag for audio
			crackling = true
			
			# Flag each hand as in use
			for hand in hand_nodes:
				hands.get_node_status(hand).current_spell = LIGHTNING_SPELL
		else:
			# Unflag hands
			for hand in hand_nodes:
				hands.get_node_status(hand).current_spell = 0
	else:
		# Unflag hands only if previously in use
		for hand in hand_nodes:
			var status = hands.get_node_status(hand)
			if(status.current_spell == LIGHTNING_SPELL):
				status.current_spell = 0
	
	# Turn on crackle effect if spell active, don't otherwise
	if crackling && !crackle.playing:
		crackle.play()
	elif !crackling:
		crackle.stop()
