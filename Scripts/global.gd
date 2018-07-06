extends Node
var action
var viewport_scale
onready var world = get_node("/root/World")
var map
var updatelist = {}
var dialog = {}
var database = {}
var map_folder
var mazenum

func _ready():
	var viewport = get_node("/root/").get_children()[1].get_viewport_rect().size
	viewport_scale = 400 / viewport.y
	world.dialog =loading("dialog")
	world.database = loading("database")
	map_folder = world.database["Player"]['location'] 

	
func savedatabase(newdata):
	var file = File.new()
	if file.open(str("res://database.json"), File.WRITE) != 0:
		print("Error opening file")
		return
	else:
		file.store_line(newdata.to_json())
		file.close()

func loading(data):
	var file = File.new()
	if file.open("res://"+data+".json", file.READ) != 0:
		print("Error opening file1")
	else:
		var text = file.get_as_text()
		var data ={}
		data.parse_json(text)
		file.close()
		return data

func action(actiontext, mapfolder):
	#world.database["Player"]["skull"] 
	action = actiontext
	if action.has("porting") == true:
		if typeof(action['porting']) == 3:
			for maze in world.database["Player"]["maze"]:
				if int(maze) == int(action['porting']):
					world.dialognode.new_text("nocode")
					return
				else:
					pass
			mazenum = int(action['porting'])
			world.porting("maze")
			world.dialognode.hide()
			world.GUInode.show_all()
		
		if typeof(action['porting']) == 4:
			if action['porting'] == "out":
				world.porting(world.previous_map)
				world.database["Player"]["maze"].append(mazenum)
	else:
		pass
		
	if action.has("changemoney") == true:
		if world.database["Player"]["money"] + int(action['changemoney']) < 0:
			world.dialognode.new_text(str(action['reqnotmet']))
			return
		else:
			world.database["Player"]["money"] += int(action['changemoney'])
	else:
		pass
		
	if action.has("permremove"):
		for item in action['permremove']:
			if world.mapnode.wall.get_node(item) != null:
				if not dupechecker(item, world.database[mapfolder]["permremove"]):
					world.mapnode.wall.get_node(item).queue_free()
			if world.database[mapfolder]['permremove'].empty():
				world.database[mapfolder]["permremove"].append(item)
				#savedatabase(world.database)
			else:
				for permremove in world.database[mapfolder]['permremove']:
					if item == permremove:
						pass
					else:
						if not dupechecker(item, world.database[mapfolder]["permremove"]):
							world.database[mapfolder]["permremove"].append(item)
						#savedatabase(world.database)
						pass

func dupechecker(item, list):
	for i in list:
		if i == item:
			return true
	return false
	
func map_ready(children):
	var wall
	var startingpos
	var name
	var child
	var pos
	var extents
	var default_data
	var interactables_list = []
	var port_list = []
	for i in children:
		if i.get_type() == "Node2D":
			wall = i
	var interactables = wall.get_children()
	
	for i in interactables:
		if i.is_in_group("interactable"):
			if i.get_name() == "Player":
				startingpos = Vector2(200,200)
				pass
			else:
				map = get_name()
				name = i.get_name()
				child = i.get_children()
				child = child[0]
				pos = child.get_global_pos()
				extents = child.get_shape().get_extents()
				default_data = {
				'map' : map,
				'name' : name,
	            'hpos': Vector2(pos.x + extents.x + 32, pos.y + extents.y + 32),
	            'lpos': Vector2(pos.x - extents.x - 32,pos.y - extents.y - 32),
				}
				interactables_list.append(default_data)
				pass

		if i.is_in_group("port"):
				map = get_name()
				name = i.get_name()
				child = i.get_children()
				child = child[0]
				pos = child.get_global_pos()
				extents = child.get_shape().get_extents()
				default_data = {
				'map' : map,
				'name' : name,
	            'hpos': Vector2(pos.x + extents.x + 32, pos.y + extents.y + 32),
	            'lpos': Vector2(pos.x - extents.x - 32,pos.y - extents.y - 32),
				}
				port_list.append(default_data)
				pass

	world.interactable_list = interactables_list
	world.port_list = port_list
	
	return wall
