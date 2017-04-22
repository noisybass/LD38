extends Node2D

var screen_size
export var tile_w = 40
export var tile_h = 54
export var map_w = 14
export var map_h = 14
var tiles = [preload("res://Scenes/Type_0.tscn"), preload("res://Scenes/Type_1.tscn"), preload("res://Scenes/Type_2.tscn"), preload("res://Scenes/Type_3.tscn")]
var map = []

func _ready():
	screen_size = get_viewport_rect().size
	generate_map()
	
func generate_map():
	
	var x_init = screen_size.x/2 - (tile_w*map_w)/2
	var y_init = screen_size.y/2 - (tile_h*map_h)/4
	
	for i in range(map_w):
		var row = []
		for j in range(map_h):
			randomize()
			var node = tiles[randi()%4+0].instance()
			node.set_map_position(i, j)
			var offset = (i % 2 == 0) * tile_w/2
			var node_x = offset + j*(tile_w)
			var node_y = i*(tile_h/2)
			row.append(node)
			add_child(node)
			node.set_global_pos(Vector2(x_init + node_x, y_init + node_y))
		map.append(row)
		
func populated(row, column, type):
	if (column >= 1):
		populate(row, column-1, type)
	if (column <= map_w-2):
		populate(row, column+1, type)
	
	if (row >= 1):
		populate(row-1, column, type)
		if (column >= 1):
			populate(row-1, column-1, type)
		if (column <= map_w-2):
			populate(row-1, column+1, type)
			
	if (row <= map_h-2):
		populate(row+1, column, type)
		if (column >= 1):
			populate(row+1, column-1, type)
		if (column <= map_w-2):
			populate(row+1, column+1, type)
			
func populate(row, column, type):
	if (type == map[row][column].type):
		map[row][column].populate()