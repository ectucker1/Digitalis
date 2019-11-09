extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var facing = transform.basis.z
	translate(-Vector3(facing.x, facing.y, facing.z).normalized() * delta * 4.0)
	if transform.origin.length() > 10:
		queue_free()
