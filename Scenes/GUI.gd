extends CanvasLayer
var buttonsize
var tempvar

func _ready():
	var viewportx = get_viewport().get_rect().size.x
	var viewporty = get_viewport().get_rect().size.y
	tempvar = get_children()[0].get_texture().get_size() * get_children()[0].get_scale()

	for i in get_children():
		i.set_scale(Vector2((viewporty/tempvar.y),(viewporty/tempvar.y)) * 0.012)
		buttonsize = i.get_texture().get_size() * i.get_scale()
		if i.get_name() == "left":
			i.set_pos(Vector2(buttonsize.x * 0.15,viewporty - buttonsize.y * 1.3))
			
		if i.get_name() == "down":
			i.set_pos(Vector2(buttonsize.x * 1.30,viewporty - buttonsize.y * 1.1))
			
		if i.get_name() == "right":
			i.set_pos(Vector2(buttonsize.x * 2.45,viewporty - buttonsize.y * 1.3))
			
		if i.get_name() == "up":
			i.set_pos(Vector2(buttonsize.x * 1.30,viewporty - buttonsize.y * 2.3))
			
		if i.get_name() == "interact":
			i.set_pos(Vector2(viewportx - buttonsize.x * 1.5,viewporty * 7/8 - buttonsize.y/2))

func hide_all():
	for i in get_children():
		i.hide()
		
func hide_move():
	for i in get_children():
		if i.get_name() == "interact":
			pass
		else:
			i.hide()
			
func show_all():
	for i in get_children():
		i.show()
