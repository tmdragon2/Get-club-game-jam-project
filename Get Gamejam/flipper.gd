extends Node2D



func _process(delta: float) -> void:
	var direction := Input.get_axis("Player_left", "Player_right")
	if direction > 0:
		scale.x = abs(scale.x) 
	if direction < 0:
		scale.x = abs(scale.x) * -1 
