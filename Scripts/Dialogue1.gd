extends Patch9Frame
onready var Name = get_node("Name")
onready var Msg = get_node("Msg")
onready var Choice1 = get_node("Choice1")
onready var Choice1_label = Choice1.get_node("Label")
onready var Choice2 = get_node("Choice2")
onready var Choice2_label = Choice2.get_node("Label")
onready var world = get_parent()
var res
var scale
var nametext = ""
var msgtext = ""
var choicetext
var actiontext

func _ready():
	res = Vector2(get_viewport().get_rect().size.x,get_viewport().get_rect().size.y/ 4)
	scale = get_node("/root/global").viewport_scale
	set_size(res * scale)
	
	Name.set_size(Vector2(get_size().x * 0.9, Name.get_size().y ))
	Name.set_pos(Vector2(get_size().x * 0.05, get_size().y * 0.05))
	Msg.set_size(Vector2(get_size().x * 0.75, get_size().y * 0.65))
	Msg.set_pos(Vector2(get_size().x * 0.05, get_size().y * 0.30))

	Choice1.set_size(Vector2(get_size().x * 0.17, get_size().y * 0.35 ))
	Choice1.set_pos(Vector2(get_size().x * 0.8,  get_size().y * 0.1))
	Choice2.set_size(Choice1.get_size())
	Choice2.set_pos(Vector2(Choice1.get_pos().x,  get_size().y * 0.55 ))
	
	Choice1_label.set_size(Choice1.get_size())
	Choice2_label.set_size(Choice1.get_size())
	
	Choice1.connect("pressed", self, "choice1_pressed")
	Choice2.connect("pressed", self, "choice2_pressed")
	
	pass

func get_camera_top_left():
    var vtrans = get_canvas_transform()
    var top_left = -vtrans.get_origin() / vtrans.get_scale()
    return top_left

func new_text(name):
	Choice1.hide()
	Choice2.hide()
	world.GUInode.show_all()
	set_pos(Vector2(get_camera_top_left().x , get_camera_top_left().y + get_size().y *3))
	if not inignorelist(world.database[world.database['Player']['location']]['permremove'], name):
		world.playernode.canmove = false
		show()
		for map in world.dialog[world.database['Player']['location']]:
			if typeof(map["code"]) == 4 and map["code"] == name:
				nametext = namechange(map["name"])
				msgtext = map["msg"]
				choicetext = map["choice"]
				if map.has("action"):
					actiontext = map["action"]
					get_node("/root/global").action(actiontext, world.database['Player']['location'])
				else:
					actiontext = ""
			elif typeof(map["code"]) == 21:
				for itemx in map["code"]:
					if itemx == name:
						nametext = namechange(map["name"])
						msgtext = map["msg"]
						choicetext = map["choice"]
						if map.has("action"):
							actiontext = map["action"]
							get_node("/root/global").action(actiontext, world.database['Player']['location'])
						else:
							actiontext = ""
			
		if typeof(choicetext) == 21:
			for choices in choicetext:
				if choices:
					world.playernode.moredialog = true
					Choice1.show()
					Choice2.show()
					Choices(choicetext)
					world.GUInode.hide_all()
				else:
					world.playernode.moredialog = false
					world.GUInode.hide_move()

		else:
				world.playernode.moredialog = false
				world.GUInode.hide_move()
		Name.set_bbcode(nametext)
		Msg.set_bbcode(msgtext)
	else:
		world.playernode.moredialog = false
	pass
	
func Choices(choicetext):
	Choice1_label.set_text(choicetext[1])
	Choice2_label.set_text(choicetext[2])
	pass
		
func choice1_pressed():
	if world.playernode.moredialog:
		new_text(Choice1_label.get_text())


func choice2_pressed():
	if world.playernode.moredialog:
		new_text(Choice2_label.get_text())
		
func namechange(name):
	if not name:
		return name
	else:
		return name + ":"
		
func inignorelist(list, item):
	for i in list:
		if i == item:
			return true
			pass
	return false