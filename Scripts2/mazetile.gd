extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var tilebase = preload("res://img/floortile.tex")

func tilebase(h):
	tilegenerator(h)
	pass

func tilegenerator(h):
	randomize()
	var x = randi()%6
	var y = randi()%4
	var set = (((h * 46) - (h * 5/4 + 4) * 32))/2 + 16
	for n in range(0, h * 5/4 + 4):
		for m in range(0, h * 5/4 + 4):
			var tile = Sprite.new()
			add_child(tile)
			tile.set_texture(tilebase)
			tile.set_region(true)
			tile.set_region_rect(Rect2(x * 32, y * 32, 32, 32))
			tile.set_pos(Vector2(n * 32 + set, m * 32 + set))
