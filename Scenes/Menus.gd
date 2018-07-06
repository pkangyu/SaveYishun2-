extends CanvasLayer
onready var button = get_node("button")
onready var display = get_node("menudisplay")
onready var mainmenu = display.get_node("mainmenu")
onready var save = display.get_node("save")
onready var credits = display.get_node("credits")
onready var backtogame = display.get_node("backtogame")
onready var creditdisplay = get_node("credits")
var blackbarspace = 15
var paused = false
var screen
var creditson = false



func _ready():
	
	screen = Vector2(get_viewport().get_rect().size.x,get_viewport().get_rect().size.y)

	
	var yheight = blackbarspace + get_viewport().get_rect().size.y * 0.10
	button.set_size(Vector2(yheight * 26/17,yheight))
	button.set_pos(Vector2(get_viewport().get_rect().size.x - button.get_size().x - blackbarspace/2, blackbarspace/2))
	
	display.set_size(screen / 2)
	display.set_pos(Vector2(0, screen.y /4))
	backtogame.connect("pressed", self, "button")
	button.connect("pressed", self, "button")
	var scale = display.get_size().y / 3.5 / backtogame.get_size().y * backtogame.get_size().x
	for i in display.get_children():
		i.set_size(Vector2(scale, display.get_size().y / 3.5))
		i.get_node("Label").set_pos(Vector2(i.get_size().x/2 - i.get_node("Label").get_size().x/2, i.get_size().y/2 - i.get_node("Label").get_size().y/2))
	
	var spacingx = (display.get_size().x - backtogame.get_size().x * 2)/3
	var spacingy = (display.get_size().y - backtogame.get_size().y * 2)/3
	save.set_pos(Vector2(spacingx, spacingy))
	backtogame.set_pos(Vector2(spacingx, spacingy * 2 + backtogame.get_size().y))
	credits.set_pos(Vector2(spacingx * 2 + backtogame.get_size().x, spacingy))
	mainmenu.set_pos(Vector2(spacingx * 2 + backtogame.get_size().x, spacingy * 2 + backtogame.get_size().y))

	creditdisplay.set_pos(display.get_pos())
	creditdisplay.set_size(display.get_size())
	creditdisplay.get_node("backtogame").set_size(Vector2(creditdisplay.get_size().x - 30, creditdisplay.get_size().x * 0.1))
	creditdisplay.get_node("backtogame").set_pos(Vector2(15, creditdisplay.get_size().y * 0.75))
	var temperory = creditdisplay.get_node("backtogame").get_node("Label")
	temperory.set_pos(Vector2(creditdisplay.get_node("backtogame").get_size().x / 2 - temperory.get_size().x/2,creditdisplay.get_node("backtogame").get_size().y / 2 - temperory.get_size().y/2))
	
	credits.connect("pressed", self, "creditson")
	creditdisplay.get_node("backtogame").connect("pressed", self, "creditson")
	
func button():
	get_tree().set_pause(not paused)
	paused = not paused
	if paused:
		display.show()
	else:
		display.hide()
	pass
	
func creditson():
	creditson = not creditson
	if creditson:
		creditdisplay.show()
	else:
		creditdisplay.hide()
	