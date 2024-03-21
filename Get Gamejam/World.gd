extends Node2D
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.MEDIUM_SEA_GREEN)
	Levelbeaten.Levelbeaten.connect(show_level_completed)



func show_level_completed():
	color_rect.show()
	get_tree().paused = true 
