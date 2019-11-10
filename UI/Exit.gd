extends Spatial

# Exit the gane when escape is pressed
func _input(event):
	if event is InputEventKey:
		if(event.is_pressed()):
			if(event.scancode == KEY_ESCAPE):
				get_tree().quit()
