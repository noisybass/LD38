extends Sprite

var textures = [preload("res://Graphics/Characters/alienYellow.png"), preload("res://Graphics/Characters/alienGreen.png"), preload("res://Graphics/Characters/alienBlue.png"), preload("res://Graphics/Characters/alienPink.png")]
var type = 0

func _ready():
	set_texture(textures[type])
	get_node("anim").play("spawn")
	
func set_type(n):
	type = n