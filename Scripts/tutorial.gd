extends TextureFrame

func _on_menu_pressed():
	get_node("/root/global").goto_scene("res://Scenes/Menu.tscn")

func _ready():
	get_node("Menu").connect("pressed", self, "_on_menu_pressed")
