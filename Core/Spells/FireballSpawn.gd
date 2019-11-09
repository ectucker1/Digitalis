extends Spatial

var FIREBALL_SCENE = preload("res://Core/Spells/Fireball.tscn")
var FIREBALL_RATE = 0.5

var console
var hands

var countdown = FIREBALL_RATE

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Console", true, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	console.cleartext()
	countdown -= delta
	var fired = false
	for transform in hands.get_transforms("Index_Metacarpal"):
		console.printline(str(transform.basis.z))
		if transform.basis.z.z > -1.1:
			if countdown < 0:
				var fireball = FIREBALL_SCENE.instance()
				add_child(fireball)
				fireball.global_transform = transform
				fired = true
	
	if fired:
		countdown = FIREBALL_RATE