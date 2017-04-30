extends Node2D

var screen_size
export var tile_w = 40
export var tile_h = 54
export var map_w = 14
export var map_h = 14
var tiles = [preload("res://Scenes/Type_0.tscn"), preload("res://Scenes/Type_1.tscn"), preload("res://Scenes/Type_2.tscn"), preload("res://Scenes/Type_3.tscn")]
var map = []
var pending = []
var frames_count = 0
var frames_max = 10

var end = false

var game

func _ready():
	screen_size = get_viewport_rect().size
	game = get_parent()
	generate_map()
	set_process(true)
	
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
		
func clicked(node):
	if (game.movements > 0):
		node.populate()
		game.spend_movement()
		if (game.movements == 0):
			end = true
		
func populated(node, row, column, type):
	get_parent().add_score(1)
	
	if (node.column >= 1):
		populate(node.row, node.column-1, node)
	if (node.column <= map_w-2):
		populate(node.row, node.column+1, node)
	
	if (node.row >= 1):
		populate(node.row-1, node.column, node)
		if (node.column >= 1):
			populate(node.row-1, node.column-1, node)
		if (node.column <= map_w-2):
			populate(node.row-1, node.column+1, node)
			
	if (node.row <= map_h-2):
		populate(node.row+1, node.column, node)
		if (node.column >= 1):
			populate(node.row+1, node.column-1, node)
		if (node.column <= map_w-2):
			populate(node.row+1, node.column+1, node)
			
func populate(row, column, node):
	var source_pos = node.get_global_pos()
	var target_pos = map[row][column].get_global_pos()
	if (source_pos.distance_to(target_pos) <= 50):
		if (node.type == map[row][column].type):
			pending.append(map[row][column])
		else:
			check(map[row][column], node.type)
			
func check(node, type):
	if (!node.isPopulated):
		var populated_count = 0
		var source_pos = node.get_global_pos()
		var target_pos
		
		if (node.column >= 1):
			target_pos = map[node.row][node.column-1].get_global_pos()
			if (map[node.row][node.column-1].isPopulated && source_pos.distance_to(target_pos) <= 50):
				populated_count += 1
		if (node.column <= map_w-2):
			target_pos = map[node.row][node.column+1].get_global_pos()
			if (map[node.row][node.column+1].isPopulated && source_pos.distance_to(target_pos) <= 50):
				populated_count += 1
		
		if (node.row >= 1):
			target_pos = map[node.row-1][node.column].get_global_pos()
			if (map[node.row-1][node.column].isPopulated && source_pos.distance_to(target_pos) <= 50):
				populated_count += 1
			if (node.column >= 1):
				target_pos = map[node.row-1][node.column-1].get_global_pos()
				if (map[node.row-1][node.column-1].isPopulated && source_pos.distance_to(target_pos) <= 50):
					populated_count += 1
			if (node.column <= map_w-2):
				target_pos = map[node.row-1][node.column+1].get_global_pos()
				if (map[node.row-1][node.column+1].isPopulated && source_pos.distance_to(target_pos) <= 50):
					populated_count += 1
				
		if (node.row <= map_h-2):
			target_pos = map[node.row+1][node.column].get_global_pos()
			if (map[node.row+1][node.column].isPopulated && source_pos.distance_to(target_pos) <= 50):
				populated_count += 1
			if (node.column >= 1):
				target_pos = map[node.row+1][node.column-1].get_global_pos()
				if (map[node.row+1][node.column-1].isPopulated && source_pos.distance_to(target_pos) <= 50):
					populated_count += 1
			if (node.column <= map_w-2):
				target_pos = map[node.row+1][node.column+1].get_global_pos()
				if (map[node.row+1][node.column+1].isPopulated && source_pos.distance_to(target_pos) <= 50):
					populated_count += 1
					
		if (populated_count >= 3):
			node.change(type)
			populate(node.row, node.column, node)
		
func _process(delta):
	frames_count += 1;
	if (frames_count == frames_max):
		frames_count = 0
		if (!pending.empty()):
			var node = pending.back()
			pending.pop_back()
			node.populate()
		elif (end):
			end = false
			get_parent().new_level()