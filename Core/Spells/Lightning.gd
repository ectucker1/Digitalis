extends Spatial

const LIGHTNING_SPELL = 3

var console
var hands
var crackle
var lighting

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Console", true, false)
	lighting = get_node("Effect")
	crackle = get_parent().get_node("Crackle")

func _pick_hands(choices):
	var hands = []
	for choice in choices:
		if hands.size() < 2:
			hands.append(choice)
		else:
			var origin_length_1 = hands[0].global_transform.origin.length()
			var origin_length_2 = hands[1].global_transform.origin.length()
			var origin_length_choice = choice.global_transform.origin.length()
			if origin_length_1 > origin_length_2:
				if origin_length_1 > origin_length_choice:
					hands[0] = choice
			elif origin_length_2 > origin_length_1:
				if origin_length_2 > origin_length_choice:
					hands[1] = choice
	
	if hands.size() == 2:
		if hands[0].global_transform.origin.x > hands[1].global_transform.origin.x:
			var temp = hands[0]
			hands[0] = hands[1]
			hands[1] = temp
	
	return hands

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hand_nodes = _pick_hands(hands.get_nodes(""))
	lighting.hide()
	
	var crackling = false
	if hand_nodes.size() == 2:
		var dir1 = hand_nodes[0].global_transform.basis.z 
		var dir2 = hand_nodes[1].global_transform.basis.z
		var angle = acos(dir1.dot(dir2) / dir1.length() / dir2.length())
		if angle > 0.4:
			var pos1 = hand_nodes[0].global_transform.origin
			var pos2 = hand_nodes[1].global_transform.origin
			var scale = (pos1 - pos2).length()
			lighting.look_at_from_position(pos1, pos2, Vector3(0, 1, 0))
			lighting.scale = Vector3(scale, scale, scale)
			lighting.show()
			
			crackling = true
			
			for hand in hand_nodes:
				hands.get_node_status(hand).current_spell = LIGHTNING_SPELL
		else:
			for hand in hand_nodes:
				hands.get_node_status(hand).current_spell = 0
	else:
		for hand in hand_nodes:
			var status = hands.get_node_status(hand)
			if(status.current_spell == LIGHTNING_SPELL):
				status.current_spell = 0
	
	if crackling && !crackle.playing:
		crackle.play()
	elif !crackling:
		crackle.stop()
