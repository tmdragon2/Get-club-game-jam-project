extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimatedSprite2D

func _ready():
	add_to_group("Enemy")
	anim.play("Snake_attack")
	
func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta


	move_and_slide()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	pass
