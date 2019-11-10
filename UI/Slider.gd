extends Label

# Display slider value as a number
func _process(delta):
	set_text(str(get_parent().get_value()))
