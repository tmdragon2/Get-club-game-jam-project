extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var start_pos = global_position
@onready var coyotejumptimer: Timer = $Coyotejumptimer
@onready var anim =  $flipper/AnimatedSprite2D
var enemy_in_attack_range = false
var player_attack_cooldown = true
var player_alive = true 
func _process(delta):
	player_attack()
	
	if self.position.y >= 750.0:
		global_position = start_pos
		var start_pos = true
		print("player died")
func handle_jump():
	if is_on_floor() or coyotejumptimer.time_left >  0.0:
		if Input.is_action_just_pressed("Player_Jump"):
			velocity.y = JUMP_VELOCITY
			anim.play("Player_Jump") 
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
	if direction > 0:
		pass
		#$flipper/AnimatedSprite2D.flip_h = false
	if direction < 0:
		#$flipper/AnimatedSprite2D.flip_h = true
		pass
	if direction:
		velocity.x = direction * SPEED
		$flipper/Hitbox_detector.scale.x = abs($flipper/Hitbox_detector.scale.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
func player_attack():
	var hurtbox_detected = $flipper/Hitbox_detector.get_overlapping_areas() 
	if Input.is_action_just_pressed("Attack"):
		for area in hurtbox_detected:
			var parent = area.get_parent()
			if parent.is_in_group("Enemy"):
				area.get_parent().queue_free()
				print(parent.name," was hit")

func die():
	pass
