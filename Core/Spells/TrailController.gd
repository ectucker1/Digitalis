extends Spatial

var console
var hands
var Chimes

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Peephole", true, false)
	Chimes = get_node(Chimes)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var particles = hands.get_nodes("Particles") 
	var indexes = hands.get_positions("Index_Distal")
	var middles = hands.get_positions("Middle_Distal")
	var rings = hands.get_positions("Ring_Distal")
	var pinkys = hands.get_positions("Pink_Distal")
	console.cleartext()
	for i in range(0, indexes.size()):
		var index = indexes[i]
		var average_other = (middles[i] + rings[i] + pinkys[i]) / 3.0
		if index.distance_to(average_other) > 0.2:
			particles[i].set_emitting(true)
			Chimes.play()
		else:
			particles[i].set_emitting(false)
		