extends Spatial

const FIREBALL_SPEED = 4.0
const MAX_DIST = 10.0

# Move the fireball foward in the direction it's facing
func _process(delta):
	var facing = transform.basis.z
	translate(-Vector3(facing.x, facing.y, facing.z).normalized() * delta * FIREBALL_SPEED)
	if transform.origin.length() > MAX_DIST:
		queue_free() # Remove once far from start
