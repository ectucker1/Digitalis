extends Spatial

var FIREBALL_SCENE = preload("res://Core/Spells/Fireball.tscn")
var FIREBALL_RATE = 0.5
var FIREBALL_SPELL = 2

var console
var hands

var countdown = FIREBALL_RATE

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Console", true, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown -= delta
	
	var fired = false
	for i in range(hands.num_hands()):
		var current_spell = hands.get_status(i).current_spell
		if current_spell == FIREBALL_SPELL or current_spell == 0:
			var transform = hands.get_transforms("Index_Metacarpal")[i]
			if transform.basis.z.z > -1.1:
				if countdown < 0:
					var fireball = FIREBALL_SCENE.instance()
					add_child(fireball)
					fireball.global_transform = transform
					fired = true
				hands.get_status(i).current_spell = FIREBALL_SPELL
			else:
				hands.get_status(i).current_spell = 0
	
	if fired:
		countdown = FIREBALL_RATE