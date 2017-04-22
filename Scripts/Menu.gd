extends TextureFrame

func _on_button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _ready():
	get_node("Play").connect("pressed", self, "_on_button_pressed")
