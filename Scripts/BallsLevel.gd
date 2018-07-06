extends CanvasLayer
onready var world = get_parent()
onready var Images = get_node("Images")
onready var BallsDisplay = Images.get_node("BallsDisplay")
onready var percent = Images.get_node("percent")
onready var BallsEmpty = Images.get_node("BallsEmpty")
onready var BallsFull = Images.get_node("BallsFull")
onready var Ballness = Images.get_node("ball")
onready var Ballnessdisplay = Ballness.get_node("Label")
onready var varient = Images.get_node("Label")
onready var GreenHC = Images.get_node("GreenHC")
onready var RedHC = Images.get_node("RedHC")
onready var coin = Images.get_node("coin")
onready var skull = Images.get_node("skull")
var res
var labelsize
var blackbarspace = 15
var xmax
var ymax
var currentpercent = 0
var timechange = 0
var intialpercent =0
var delta_health = 0
var intial_label
var displayX
var displayY

var currenthealthbar = 0


func _ready():
	
	
	Images.set_pos(Vector2(0,0))
	res = Vector2(get_viewport().get_rect().size.x * 0.5,get_viewport().get_rect().size.y)
	labelsize= varient.get_size()
	BallsDisplay.set_size(Vector2(res.x, blackbarspace * 2 + res.y * 0.05))
	varient.set_pos(Vector2(blackbarspace * 2, BallsDisplay.get_size().y / 2 - labelsize.y / 2))
	
	
	BallsEmpty.set_size(Vector2(res.x - labelsize.x - blackbarspace * 5, res.y * 0.03))
	BallsEmpty.set_pos(Vector2(labelsize.x + blackbarspace * 3, BallsDisplay.get_size().y / 2 - BallsEmpty.get_size().y / 2))
	percent.set_pos(Vector2(BallsEmpty.get_pos().x + BallsEmpty.get_size().x/ 2 - percent.get_size().x/2,varient.get_pos().y))
	BallsFull.set_size(Vector2(0,BallsEmpty.get_size().y))
	BallsFull.set_pos(BallsEmpty.get_pos())

	
	Ballness.set_size(Vector2(Ballnessdisplay.get_size().x + 64, BallsDisplay.get_size().y))
	Ballness.set_pos(Vector2(BallsEmpty.get_pos().x - Ballness.get_size().x/2,BallsEmpty.get_pos().y + BallsEmpty.get_size().y/2))
	Ballnessdisplay.set_pos(Vector2(32,Ballness.get_size().y/2))
	
	GreenHC.set_pos(Vector2(BallsDisplay.get_size().x +20, BallsDisplay.get_size().y/2 - GreenHC.get_size().y/2 ))
	RedHC.set_pos(GreenHC.get_pos())
	
	displayX = GreenHC.get_pos().x
	displayY = GreenHC.get_pos().y
	
	intial_label = Ballness.get_pos().x

	
	xmax = BallsEmpty.get_size().x
	ymax = BallsEmpty.get_size().y
	
	coin.set_size(Vector2(BallsDisplay.get_size().y, BallsDisplay.get_size().y))
	skull.set_size(coin.get_size())
	coin.set_pos(Vector2(GreenHC.get_pos().x + GreenHC.get_size().x + 20, 0))
	skull.set_pos(Vector2(GreenHC.get_pos().x + GreenHC.get_size().x * 2 + 40 + skull.get_size().x, 0))
	coin.get_node("Label").set_pos(Vector2(coin.get_size().x + 10, BallsDisplay.get_size().y /2 - coin.get_node("Label").get_size().y /2))
	skull.get_node("Label").set_pos(Vector2(coin.get_size().x + 10, BallsDisplay.get_size().y /2 - coin.get_node("Label").get_size().y /2))
	return

func settext(healthbar, delta):
	if currenthealthbar == healthbar:
		return
	else:
		currenthealthbar = healthbar
		percent.set_text(str(currenthealthbar)+"% / 100%")
		return


func setsize(percent, delta):
		if currentpercent == percent:
			pass
		#no change in input
		else:
			currentpercent = percent
			intialpercent = intialpercent + delta_health
			delta_health = currentpercent - intialpercent
			timechange = 0
		
			pass
		timechange += delta
		healthchange()
		sizesetter(timechange, intialpercent, delta_health)
		ballness()
		set_skull_money()
		return
		
func sizesetter(time_change, intial_percentage, change_inhealth):
		if 0 < time_change < 0.2:
			BallsFull.set_size(Vector2((intial_percentage + change_inhealth*0.5)/100 * xmax , ymax))
			setopacity(0.2, 30)
			return

		elif 0.1 < time_change < 0.4:
			BallsFull.set_size(Vector2((intial_percentage + change_inhealth*0.75)/100 * xmax , ymax))
			setopacity(0.5, 20)
			return

		elif 0.2 < time_change < 0.6:
			BallsFull.set_size(Vector2((intial_percentage + change_inhealth*0.85)/100 * xmax , ymax))
			setopacity(0.7, 10)
			return

		elif 0.6 < time_change < 0.8:
			BallsFull.set_size(Vector2((intial_percentage + change_inhealth*0.95)/100 * xmax , ymax))
			setopacity(1, 0)
			return

		elif time_change > 1:
			BallsFull.set_size(Vector2((intial_percentage + change_inhealth * 0.9999)/100 * xmax , ymax))
			setopacity(0, 0)
			return

func ballness():
	Ballness.set_pos(Vector2(intial_label + BallsFull.get_size().x,Ballness.get_pos().y))
	var textalert = BallsFull.get_size().x / BallsEmpty.get_size().x

	if 0 < textalert and textalert < 0.1:
		Ballnessdisplay.set_text("Ball-less")
		return
	if 0.1 < textalert and textalert < 0.3:
		Ballnessdisplay.set_text("Humji")
		return
	if 0.3 < textalert and textalert < 0.5:
		Ballnessdisplay.set_text("Tiny. Just Tiny")
		return
	if 0.5 < textalert and textalert < 0.6:
		Ballnessdisplay.set_text("It's Growing")
		return
	if 0.6 < textalert and textalert < 0.7:
		Ballnessdisplay.set_text("Softened Balls")
		return
	if 0.8 < textalert and textalert < 0.9:
		Ballnessdisplay.set_text("Hardened Balls")
		return
	if 0.9 < textalert and textalert < 1:
		Ballnessdisplay.set_text("Balls Of Steel!")
	return
func healthchange():
	if delta_health > 0:
		GreenHC.show()
		RedHC.hide()
		GreenHC.set_text("+ " + str(delta_health))
	if delta_health < 0:
		RedHC.show()
		GreenHC.hide()
		RedHC.set_text(str(delta_health))
	return
func setopacity(num, negaheight):
	GreenHC.set_opacity(num)
	RedHC.set_opacity(num)
	GreenHC.set_pos(Vector2(displayX,displayY - negaheight))
	RedHC.set_pos(Vector2(displayX,displayY - negaheight))
	return
func set_skull_money():
	skull.get_node("Label").set_text(str(world.database['Player']['skull']))
	coin.get_node("Label").set_text(str(world.database['Player']['money']))