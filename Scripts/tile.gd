extends Sprite

export(int, "Type_0", "Type_1", "Type_2", "Type_3") var type
var life = preload("res://Scenes/Life.tscn")

var type_0 = preload("res://Graphics/Tiles/tileLava.png")
var type_1 = preload("res://Graphics/Tiles/tileGrass.png")
var type_2 = preload("res://Graphics/Tiles/tileWater.png")
var type_3 = preload("res://Graphics/Tiles/tileMagic.png")

var row
var column
var material
var isPopulated = false

func _ready():
	material = get_material()
	set_material(null)

func set_map_position(r, c):
	row = r
	column = c
	
func change(new_type):
	type = new_type
	if(type == 0):
		set_texture(type_0)
	elif (type == 1):
		set_texture(type_1)
	elif (type == 2):
		set_texture(type_2)
	else:
		set_texture(type_3)
	
func populate():
	if (!isPopulated):
		isPopulated = true
		var node = life.instance()
		node.set_modulate(Color(0, 0, 0, 0))
		node.set_type(type)
		add_child(node)
		get_parent().populated(self, row, column, type)
		#print("populated " + str(row) + "," + str(column) + " type: " + str(type))

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if (event.type==InputEvent.MOUSE_BUTTON and event.pressed):
		#populate()
		get_parent().clicked(self)

func _on_Area2D_mouse_enter():
	#if (!isPopulated):
		set_material(material)

func _on_Area2D_mouse_exit():
	#if (!isPopulated):
		set_material(null)
