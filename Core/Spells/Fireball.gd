extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(transform.basis.z.normalized() * delta * 5.0)
	if transform.origin.length() > 10:
		queue_free()
