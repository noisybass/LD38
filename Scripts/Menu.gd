extends TextureFrame

func _on_play_pressed():
	get_node("/root/global").goto_scene("res://Scenes/Game.tscn")
	
func _on_tutorial_pressed():
	get_node("/root/global").goto_scene("res://Scenes/tutorial.tscn")

func _ready():
	get_node("Play").connect("pressed", self, "_on_play_pressed")
	get_node("Tutorial").connect("pressed", self, "_on_tutorial_pressed")
	get_node("MaxScore").set_text("Highscore: " + str(get_node("/root/global").highscore))
