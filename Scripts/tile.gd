extends Sprite

export(int, "Type_0", "Type_1", "Type_2", "Type_3") var type

var row
var column
var material

func _ready():
	material = get_material()
	set_material(null)

func set_map_position(r, c):
	row = r
	column = c

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if (event.type==InputEvent.MOUSE_BUTTON and event.pressed):
		print("selected " + str(row) + "," + str(column) + " type: " + str(type))


func _on_Area2D_mouse_enter():
	set_material(material)


func _on_Area2D_mouse_exit():
	set_material(null)
