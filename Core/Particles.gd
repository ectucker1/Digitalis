extends Particles

var console
var hands

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Peephole", true, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	console.cleartext()
	if !hands.hands.empty():
		console.printline(str(hands.get_transforms("").front().basis.z))
		console.printline(str(hands.get_transforms("").front().basis.z.z < 1.0))
	var indexes = hands.get_positions("Index_Distal")
	if !indexes.empty():
		get_process_material().set_shader_param("hand_pos", indexes.front())
