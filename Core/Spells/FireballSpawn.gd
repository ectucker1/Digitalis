extends Spatial

var FIREBALL_SCENE = preload("res://Core/Spells/Fireball.tscn")
const FIREBALL_RATE = 0.5
const FIREBALL_SPELL = 2
const BASIS_MIN_Z = -1.1

#var console
var hands

var countdown = FIREBALL_RATE

func _ready():
	hands = get_parent().get_node("Hands")
	#console = get_parent().find_node("Console", true, false)

# Fireball control process
func _process(delta):
	countdown -= delta
	
	var fired = false
	# For each hand
	for i in range(hands.num_hands()):
		var current_spell = hands.get_status(i).current_spell
		# If it's not being used by another spell
		if current_spell == FIREBALL_SPELL or current_spell == 0:
			var transform = hands.get_transforms("Index_Metacarpal")[i]
			# If it's at a great enough angle
			if transform.basis.z.z > BASIS_MIN_Z:
				if countdown < 0:
					# Spawn a fireball
					var fireball = FIREBALL_SCENE.instance()
					add_child(fireball)
					# Set fireball position and rotation
					fireball.global_transform = transform
					fired = true
				# Flag hand as in use
				hands.get_status(i).current_spell = FIREBALL_SPELL
			else:
				# Hand is now free
				hands.get_status(i).current_spell = 0
	
	# Rest fire countdown
	if fired:
		countdown = FIREBALL_RATE