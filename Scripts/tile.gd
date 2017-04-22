extends Sprite

export(int, "Type_0", "Type_1", "Type_2", "Type_3") var type

var row
var column
var material
var life = false

func _ready():
	material = get_material()
	set_material(null)

func set_map_position(r, c):
	row = r
	column = c
	
func populate():
	if (!life):
		life = true
		set_material(material)
		get_parent().populated(row, column, type)
		print("populated " + str(row) + "," + str(column) + " type: " + str(type))

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if (event.type==InputEvent.MOUSE_BUTTON and event.pressed):
		populate()

func _on_Area2D_mouse_enter():
	if (!life):
		set_material(material)
		set_scale(Vector2(1.1, 1.1))


func _on_Area2D_mouse_exit():
	if (!life):
		set_material(null)
		set_scale(Vector2(1, 1))
