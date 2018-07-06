extends Node2D
var mapnode
var interactable_list
var dialognode
var playernode
var GUInode
var database
var dialog
var mapstring
var port_list
var previous_map
func _ready():
	playernode = get_node("Player")
	dialognode = get_node("Dialogue")
	GUInode = get_node("GUI")
	map_rdy()
	return
	
func map_rdy():
	resetmovement()
	for i in get_tree().get_nodes_in_group("map"):
		i.queue_free()
		pass

	mapstring = "res://Scenes/"+str(database['Player']['location'])+"/map.scn"
	add_child(load(mapstring).instance())
	update()
	return

func update():
	for item in database[database['Player']['location']]['permremove']:
		if mapnode.wall.get_node(item) != null:
				mapnode.wall.get_node(item).queue_free()
	return

func porting(map):
	previous_map = database['Player']['location']
	database['Player']['location'] = str(map)
	map_rdy()
	
func resetmovement():
	playernode.moredialog = false
	playernode.canmove = true
	GUInode.show_all()
	dialognode.hide()
