extends KinematicBody2D

var MOTION_SPEED = 140

var Raynode
var animation = ""
var animationNew = ""
var animationPlayer
var canmove = true
var list = []
onready var world = get_parent()
var name
var moredialog = false
var health
var heathchangetime = 0


func _ready():
	set_fixed_process(true)
	set_process_input(true)
	Raynode = get_node("RayCast2D")
	animationPlayer = get_node("AnimatedSprite")
	world = get_parent()
	health = world.get_node("Health")
	get_node("Camera2D").set_zoom(get_node("Camera2D").get_zoom()* get_node("/root/global").viewport_scale)
	set_pos(Vector2(world.database['Player']['startingposx'],world.database['Player']['startingposy']))
	pass

func _fixed_process(delta):

	var motion = Vector2()
	
	if canmove:
		if (Input.is_action_pressed("ui_up")):
			motion += Vector2(0,-1)
			Raynode.set_rotd(180)
	
		if (Input.is_action_pressed("ui_down")):
			motion += Vector2(0,1)
			Raynode.set_rotd(0)

		if (Input.is_action_pressed("ui_left")):
			motion += Vector2(-1,0)
			Raynode.set_rotd(-90)
			
		if (Input.is_action_pressed("ui_right")):
			motion += Vector2(1,0)
			Raynode.set_rotd(90)
		else:
			pass
	motion = motion.normalized() * MOTION_SPEED * delta
	if motion.length() == 0:
		animation = "idle"
	elif motion.y < 0:
		animation = "up"
	elif motion.y > 0:
		animation = "down"
	elif motion.x > 0:
		animation = "right"
	elif motion.x < 0:
		animation = "left"
	if animation != animationNew:
		animationNew = animation
		animationPlayer.play(animation)
	move(motion)
	porting()
	heathchangetime += delta
	if heathchangetime > 8 and world.database['Player']['health'] < 100:
		world.database['Player']['health'] +=1
		heathchangetime = 0

	health.setsize(world.database['Player']['health'], delta)
	health.settext(world.database['Player']['health'], delta)

func _input(event):
	if typeof(world.interactable_list) == 0:
		print("Interact list got problem")
		return
	else:

		for i in world.interactable_list:
			if (
			i.lpos.x < get_global_pos().x and 
			get_global_pos().x < i.hpos.x and
			i.lpos.y < get_global_pos().y and 
			get_global_pos().y < i.hpos.y and
			(event.is_action_pressed("ui_select")) and not 
			event.is_echo()
			):

				if not moredialog:
					if canmove:
						world.dialognode.new_text(i.name)
						return
					else:
						canmove = true
						world.dialognode.hide()
						world.GUInode.show_all()
						return
				else:
					pass
			else:
				pass
func porting():
	if typeof(world.port_list) == 0:
		print("Port list got problem")
		return
	else:
		for i in world.port_list:
			if (i.lpos.x < get_global_pos().x and 
			get_global_pos().x < i.hpos.x and
			i.lpos.y < get_global_pos().y and
			get_global_pos().y < i.hpos.y
				):
				world.porting(i.name)