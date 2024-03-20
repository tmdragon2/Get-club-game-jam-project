extends CharacterBody2D


var speed = -200.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false
@onready var anim =  $AnimatedSprite2D
func _ready():
	add_to_group("Enemy")
	anim.play("roll_move")
func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	if is_on_wall():
		flip()
	velocity.x = speed
	move_and_slide()
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1 


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
