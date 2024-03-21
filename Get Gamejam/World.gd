extends Node2D
@onready var color_rect = $CanvasLayer/ColorRect

@onready var enemies_left = get_tree().get_nodes_in_group("Enemy")

func _ready():
	RenderingServer.set_default_clear_color(Color.MEDIUM_SEA_GREEN)
	Level_completed.Level_completed.connect(show_level_completed)
	if enemies_left.size() == 1:
		Level_completed.show
		print("yo")


func show_level_completed():
	Level_completed.show()
	get_tree().paused = true 
