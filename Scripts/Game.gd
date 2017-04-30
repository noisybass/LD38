extends Sprite

#export var base_time = 15
#export var delta_time = 2
export var base_score = 10
export var delta_score = 5
export var base_movements = 6
export var delta_movements = 1

var map = preload("res://Scenes/Map.tscn")
var header = preload("res://Scenes/Header.tscn")

var total_score = 0
var level_score = 0
var level = 0
var level_movements = 0
#var level_time = 0
var level_beat_score = 0

var movements = 0
#var time = 0

var current_delta = 0
var max_delta = 1
var end = false
var map_node
var header_node

func _on_button_pressed():
	get_node("/root/global").goto_scene("res://Scenes/Menu.tscn")

func _ready():
	get_node("Menu").connect("pressed", self, "_on_button_pressed")
	start_level()
	create_map()
	set_process(true)
	
func start_level():
	#level_time = base_time - level*delta_time
	level_movements = base_movements - int(level/2)*delta_movements
	level_beat_score = base_score + level*delta_score
	
	#time = level_time
	movements = level_movements
	
	level_score = 0
	
	get_node("Level/Label").set_text("Level " + str(level + 1))
	get_node("Total Score").set_text("Total Score: " + str(total_score))
	get_node("Movements").set_text("You can do " + str(movements) + " more movements")
	get_node("Beat").set_text("Reach " + str(level_beat_score) + " points")
	
func _process(delta):
	if (end):
		current_delta += delta
	
		if(current_delta >= max_delta):
			current_delta = 0
			end = false
			
			if (level_score >= level_beat_score):
				total_score += level_score
				level += 1
				start_level()
				recreate_map()
			else:
				get_node("/root/global").set_highscore(total_score)
				get_node("/root/global").goto_scene("res://Scenes/Menu.tscn")
#	else:
#		time -= delta
#		get_node("Timer/TimerBack/TimerProgress").set_scale(Vector2(time/level_time, 1))
#		if (time <= 0):
#			end = true
			
func spend_movement():
	movements -= 1
	get_node("Movements").set_text("You can do " + str(movements) + " more movements")
		
func add_score(n):
	level_score += n
	get_node("Score/AnimationPlayer").play("add_score")
	get_node("Score").set_text("Score: " + str(level_score))
	
func new_level():
	end = true
	
func create_map():
	map_node = map.instance()
	add_child(map_node)
	header_node = header.instance()
	header_node.get_node("Label").set_text("Reach " + str(level_beat_score) + " points")
	add_child(header_node)
	
func recreate_map():
	map_node.queue_free()
	map_node = map.instance()
	add_child(map_node)

	header_node.queue_free()
	header_node = header.instance()
	header_node.get_node("Label").set_text("Reach " + str(level_beat_score) + " points")
	add_child(header_node)