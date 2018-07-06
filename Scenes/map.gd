extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var interactables
var children
var interactables_list = []
var pos
var extents
var default_data
var child
var map
var name

func _ready():
	children = get_children()
	for i in children:
		if i.get_type() == "Node2D":
			interactables = i
	interactables = interactables.get_children()
	
	for i in interactables:
		if i.is_in_group("interactable"):
			map = get_name()
			name = i.get_name()
			child = i.get_children()
			child = child[0]
			pos = child.get_global_pos()
			extents = child.get_shape().get_extents()
			default_data = {
			'map' : map,
			'name' : name,
            'pos': pos,
            'extents': extents,
			}
			interactables_list.append(default_data)
