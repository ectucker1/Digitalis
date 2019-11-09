extends Label

var a = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#if (a == 60):
	#	set_text("FPS: " + str(Engine.get_frames_per_second()))
	#	a = 0
	#else:
	#	a += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text("FPS: " + str(Engine.get_frames_per_second()))
