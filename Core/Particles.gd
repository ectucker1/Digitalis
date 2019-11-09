extends Particles

var leap_motion
var index_finger

func _ready():
	leap_motion = get_parent().get_node("Camera/Leap_Motion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(leap_motion.get_children().size() > 0):
		index_finger = leap_motion.get_children().front().get_node("Index")
	else:
		index_finger = null
	if(index_finger != null):
		get_process_material().set_shader_param("hand_pos", index_finger.get_global_transform().origin)
