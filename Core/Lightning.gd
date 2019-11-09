extends Spatial

var console
var hands

var lighting

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Peephole", true, false)
	lighting = get_node("Effect")

func _pick_hands(choices):
	var hands = []
	for choice in choices:
		if hands.size() < 2:
			hands.append(choice)
		else:
			if hands[0].origin.length() > hands[1].origin.length():
				if hands[0].origin.length() > choice.origin.length():
					hands[0] = choice
			elif hands[1].origin.length() > hands[0].origin.length():
				if hands[1].origin.length() > choice.origin.length():
					hands[1] = choice
	
	if hands.size() == 2:
		if hands[0].origin.x > hands[1].origin.x:
			var temp = hands[0]
			hands[0] = hands[1]
			hands[1] = temp
	
	return hands

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var transforms = _pick_hands(hands.get_transforms(""))
	lighting.hide()
	if transforms.size() == 2:
		var dir1 = transforms[0].basis.z 
		var dir2 = transforms[1].basis.z
		var angle = acos(dir1.dot(dir2) / dir1.length() / dir2.length())
		if angle > 0.4:
			var scale = (transforms[0].origin - transforms[1].origin).length()
			lighting.look_at_from_position(transforms[0].origin, transforms[1].origin, Vector3(0, 1, 0))
			lighting.scale = Vector3(scale, scale, scale)
			lighting.show()
