extends Spatial

var FIREBALL_SCENE = preload("res://Core/Spells/Fireball.tscn")
var FIREBALL_RATE = 0.5

var console
var hands

var countdown = FIREBALL_RATE

func _ready():
	hands = get_parent().get_node("Hands")
	console = get_parent().find_node("Label", true, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown -= delta
	var fired = false
	for transform in hands.get_transforms(""):
		if transform.basis.z.z < 1.0:
			if countdown < 0:
				var fireball = FIREBALL_SCENE.instance()
				fireball.set_global_transform(transform)
				add_child(fireball)
				fired = true
	
	if fired:
		countdown = FIREBALL_RATE