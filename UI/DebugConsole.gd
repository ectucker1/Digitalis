extends Label

# printline prints a line of your choosing.
func printline(x):
	set_text(get_text() + "\n" + x)
	
# cleartext clears the text from the previous frame.
func cleartext():
	set_text("")