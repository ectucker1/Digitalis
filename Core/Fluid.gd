extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sphere = preload("res://Core/Particle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(0, 10):
		for y in range(0, 10):
			for z in range(0, 10):
				var particle = sphere.instance()
				particle.translation = Vector3(x, y, z)
				add_child(particle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
