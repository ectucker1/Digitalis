extends Particles

var hands

func _ready():
	hands = get_parent().get_node("Hands")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var indexes = hands.get_positions("Index_Distal")
	if !indexes.empty():
		get_process_material().set_shader_param("hand_pos", indexes.front())
