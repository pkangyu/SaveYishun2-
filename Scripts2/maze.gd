
extends Node

# member variables here, example:


func _ready():
	get_parent().mapnode = get_node(get_path())
	print("Its Run!")

