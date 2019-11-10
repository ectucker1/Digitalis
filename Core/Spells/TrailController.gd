extends Spatial

const SPARK_SPELL = 1

const INDEX_DISTANCE = 0.15

var console
var hands
var chimes

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Peephole", true, false)
	chimes = get_parent().get_node("Chimes")

# Sparkle/trail control process
func _process(delta):
	# List of hands
	var hand_nodes = hands.get_nodes("")
	
	# List of particle emitters, attached to hands
	var particles = hands.get_nodes("Particles")
	
	# List of specific finger positions
	var indexes = hands.get_positions("Index_Distal")
	var middles = hands.get_positions("Middle_Distal")
	var rings = hands.get_positions("Ring_Distal")
	var pinkys = hands.get_positions("Pink_Distal")
	
	var sparkle = false
	
	# For each hand
	for i in range(0, indexes.size()):
		var status = hands.get_node_status(hand_nodes[i])
		# If it is not being used for another spell
		if status.current_spell == 0 or status.current_spell == SPARK_SPELL:
			# Position of index finger
			var index = indexes[i]
			# Calculate average position of non-index fingers
			var average_other = (middles[i] + rings[i] + pinkys[i]) / 3.0
			
			if index.distance_to(average_other) > INDEX_DISTANCE:
				# Enable particle emitter
				particles[i].set_emitting(true)
				# Flag for audio
				sparkle = true
				# Flag hand as in use
				status.current_spell = SPARK_SPELL
			else:
				# Disable particle emitter
				particles[i].set_emitting(false)
				# Hand no longer in use
				status.current_spell = 0
		else:
			# Disable in case of spell switch
			particles[i].set_emitting(false)
	
	# Turn on chime effect if spell active, don't otherwise
	if sparkle && !chimes.playing:
		chimes.play()
	elif !sparkle:
		chimes.stop()