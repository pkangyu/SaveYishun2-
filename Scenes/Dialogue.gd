extends Patch9Frame
onready var Name = get_node("RichTextLabel")
onready var Msg = get_node("RichTextLabel2")
onready var Choice1 = get_node("Choice1")
onready var Choice2 = get_node("Choice2")
var printing = true
var timer = 0
var currentchar = 0
var SPEED = 0.1
var nametext = ""
var msgtext = ""
var parent
var res
var scale
var buttonspace
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	parent = get_parent()
	res = Vector2(get_viewport().get_rect().size.x,get_viewport().get_rect().size.y/ 4)
	scale = get_node("/root/global").viewport_scale
	set_size(res * scale)
	
	Name.set_size(Vector2(get_size().x * 0.9, Name.get_size().y ))
	Name.set_pos(Vector2(get_size().x * 0.05, get_size().y * 0.09))
	Msg.set_size(Vector2(get_size().x * 0.8, get_size().y * 0.65))
	Msg.set_pos(Vector2(get_size().x * 0.05, get_size().y * 0.27))
	
	#Choice1.set_size(Vector2(get_size().x * 0.12, get_size().y * 0.3 ))
	#Choice1.set_pos(Vector2(get_size().x * 0.85, get_size().y * 0.09))
	#Choice2.set_size(Vector2(get_size().x * 0.12, get_size().y * 0.3))
	#Choice2.set_pos(Vector2(get_size().x * 0.85, Choice1.get_size().y * 1.5))
	
	set_fixed_process(true)
	

	pass

func _fixed_process(delta):
	set_pos(Vector2(get_camera_top_left().x , get_camera_top_left().y + get_size().y *3))
	

func get_camera_top_left():
    var vtrans = get_canvas_transform()
    var top_left = -vtrans.get_origin() / vtrans.get_scale()
    return top_left

func new_text(name):
	for map in parent.dialog[parent.map]:
		if name in map["code"]:
			nametext = map["name"]+ ":"
			msgtext = "hihihi" #map["msg"]
			
			#if map["choice"][0] == true:
				#Choice1.set_text(map["choice"][1])

	Name.set_bbcode("rgbvtrbrfgvrgb")
	Msg.set_bbcode(msgtext)
	show()

	