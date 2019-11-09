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
	console.cleartext()
	console.printline(str(hands.get_transforms("").size()))
	var transforms = _pick_hands(hands.get_transforms(""))
	if transforms.size() > 1:
		var midpoint = (transforms[0].origin + transforms[1].origin) / 2
		#var midpoint = transforms[0].origin
		var scale = (transforms[0].origin - transforms[1].origin).length()
		#lighting.global_transform.origin = midpoint
		console.printline(str(scale))
		lighting.look_at_from_position(transforms[0].origin, transforms[1].origin, Vector3(0, 1, 0))
		#lighting.rotate_y(PI / 2)
		lighting.scale = Vector3(scale, scale, scale)
		lighting.show()
	else:
		lighting.hide()
