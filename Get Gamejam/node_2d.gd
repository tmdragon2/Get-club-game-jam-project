extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var start_pos = global_position
@onready var coyotejumptimer: Timer = $Coyotejumptimer

func _process(delta):
	if self.position.y >= 750.0:
		global_position = start_pos
		var start_pos = true
		print("player died")

func handle_jump():
	if is_on_floor() or coyotejumptimer.time_left >  0.0:
		if Input.is_action_just_pressed("Player_Jump"):
			velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		if Input.is_action_just_released("Player_Jump") and velocity.y < JUMP_VELOCITY / 2: 
			velocity.y = JUMP_VELOCITY / 2
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	var floor_left = is_on_floor()
	move_and_slide()
	var left_ledge = floor_left and not is_on_floor() and velocity.y >= 0
	if left_ledge: 
		coyotejumptimer.start()
func _on_hurtbox_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("player died")
		global_position = start_pos
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
func handle_movement(delta):
	var direction := Input.get_axis("Player_left", "Player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
func player_attack():
	if Input.is_action_just_pressed("Attack"):
		$Area2D
