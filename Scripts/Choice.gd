extends TextureButton

func _ready():
	connect("pressed", self, "_my_button_pressed")
func _my_button_pressed():
    print (str(true))