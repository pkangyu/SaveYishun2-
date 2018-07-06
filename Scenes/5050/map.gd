extends Node2D
var wall

func _ready():
	get_parent().mapnode = get_node(get_path())
	wall = get_node("/root/global").map_ready(get_children())
	set_player_pos()
	
func set_player_pos():

	if str(get_parent().previous_map) == "MRT":
		get_parent().playernode.set_global_pos(Vector2(654, 1036))
	if str(get_parent().previous_map) == "maze":
		get_parent().playernode.set_global_pos(Vector2(400, 1036))