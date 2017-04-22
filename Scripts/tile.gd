extends Sprite

export(int, "Type_0", "Type_1", "Type_2", "Type_3") var type

var row
var column

func set_map_position(r, c):
	row = r
	column = c
	