extends Sprite

var map = preload("res://Scenes/Map.tscn")

var current_delta = 0
var max_delta = 1
var node

func _ready():
	#set_process(true)
	node = map.instance()
	add_child(node)

func _process(delta):
	current_delta += delta
	
	if(current_delta >= max_delta):
		current_delta = 0
		node.queue_free()
		node = map.instance()
		add_child(node)