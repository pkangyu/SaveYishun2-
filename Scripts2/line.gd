
extends CollisionObject2D

# member variables here, example:
var datalist
var interactables_list = []
var op
var data
var path
var size = 46
var h
var w
var m = Matrix32()
var colors = [
Color("006699"),
Color("009999"),
Color("009933"),
Color("3333cc"),
Color("6600ff"),
Color("993366"),
Color("cc6600"),
Color("0066cc"),
Color("66004d"),
Color("800000"),
Color("00664d"),
Color("666600"),
Color("993d00")
]

func _ready():
	var world = get_tree().get_root().get_node("World")
	h = int(world.database['Player']['skull'] + 1) * 2 + 3
	w = h
	get_parent().get_node("tile").tilebase(h)
	get_parent().get_node("Node2D").get_node("end").set_pos(Vector2((h - 1)* 46, (h - 1 )* 46))
	datalist = {
				'map' : "maze",
				'name' : "out",
	            'hpos': Vector2((h +1) * 40, (h +1) * 40),
	            'lpos': Vector2((h +1) * 40 - 40, (h +1) * 40 - 40),
				}
	interactables_list.append(datalist)
	datalist = {
				'map' : "maze",
				'name' : "nocode",
	            'hpos': Vector2(40,40),
	            'lpos': Vector2(0,0),
				}
	interactables_list.append(datalist)
	world.interactable_list = interactables_list
	var OPMethod = load("res://scripts2/OPMethod.gd")
	op = OPMethod.new(w, h)
	data = op.createMaze()
	path = op.solveMaze(0, 0, w - 1, h - 1)
	print("line ready")


	m[0] = Vector2(1,0)
	m[1] = Vector2(0,1)
	get_parent().get_parent().playernode.set_pos(Vector2(16,16))

func _draw():
	drawMaze(data, w, h, size, size)
	drawSolve(path, w, h, size, size)
	print("line draw")

func drawMaze(data, sizeX, sizeY, width, height):
	var color = Color("006699")
	#colors[randi() % colors.size()]
	var ox = 0
	var oy = 0
	for i in range(sizeX):
		for j in range(sizeY):
			# horisontal
			if((data[i][j] & 1) == 0):
				var point1 = Vector2(ox + width * i, oy + height * j)
				var point2 = Vector2(ox + width * (i + 1), oy + height * j)
				draw_box(point1, point2, color, 2)
			
			#vertical
			if((data[i][j] & 2) == 0):
				var point1 = Vector2(ox + width * i, oy + height * j)
				var point2 = Vector2(ox + width * i, oy + height * (j + 1))
				draw_box(point1, point2, color, 2)
	#bottom
	draw_line(Vector2(ox, oy + sizeY * height), Vector2(ox + sizeX * width, oy + sizeY * height), color, 5)
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2((sizeX * width)/2, 0.1))
	m[2] = Vector2(ox + (sizeX * width)/2, oy + sizeY * height)
	add_shape(shape, m)
	#side
	draw_line(Vector2(ox + sizeX * width, oy), Vector2(ox + sizeX * width, oy + sizeY * height), color, 5)
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(0.1, (sizeX * width)/2))
	m[2] = Vector2(ox + sizeX * width, oy + (sizeX * width)/2)
	add_shape(shape, m)
	
func drawSolve(path, sizeX, sizeY, width, height):
	var color = colors[randi() % colors.size()]
	var ox = 0
	var oy = 0
	for i in range(path.size() - 1):
		var cell1 = path[i]
		var cell2 = path[i + 1]
		var point1 = Vector2(ox + width * cell1[0] + width / 2, oy + height * cell1[1] + height / 2)
		var point2 = Vector2(ox + width * cell2[0] + width / 2, oy + height * cell2[1] + height / 2)
		draw_line(point1, point2, color, 5)
		
func draw_box(point1, point2, color, integer):
	draw_line(point1, point2, color, 5)

	if point1.x == point2.x:
		if point1.y - point2.y > 0:
			var shape = RectangleShape2D.new()
			shape.set_extents(Vector2(0.1, (point1.y - point2.y)/2))
			m[2] = Vector2(point2.x, point2.y + size/2)
			add_shape(shape, m)
		else:
			var shape = RectangleShape2D.new()
			shape.set_extents(Vector2(0.1, (point2.y - point1.y)/2))
			m[2] = Vector2(point1.x, point1.y + size/2)
			add_shape(shape, m)
		draw_line(point1, point2, color, 5)

	if point1.y == point2.y:
		if point1.x - point2.x > 0:
			var shape = RectangleShape2D.new()
			shape.set_extents(Vector2((point1.x - point2.x)/2 , 0.1))
			m[2] = Vector2(point2.x + size/2, point2.y)
			add_shape(shape, m)
		else:
			var shape = RectangleShape2D.new()
			shape.set_extents(Vector2((point2.x - point1.x)/2 , 0.1))
			m[2] = Vector2(point1.x + size/2, point1.y)
			add_shape(shape, m)
		draw_line(point1, point2, color, 5)