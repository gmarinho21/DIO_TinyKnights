extends CharacterBody2D

@export var speed: float = 3

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var is_running: bool = false
var is_attacking: bool = false
var attack_cooldown: float = 0.0
	
func _process(delta: float) -> void:
	if is_attacking:
		attack_cooldown -= delta
		if attack_cooldown <= 0.0:
			is_attacking = false
			is_running = false

	
func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var target_velocity = input_vector * speed * 100.0
	if is_attacking:
		target_velocity *= 0.25
	velocity = lerp(velocity, target_velocity, 0.85)
	move_and_slide()
	
	var was_running = is_running
	is_running = not input_vector.is_zero_approx()
	
	if not is_attacking:
		if was_running != is_running:
			if is_running:
				animation_player.play("run")
			else:
				animation_player.play("idle")

		
	if 	target_velocity.x < 0:
		sprite.flip_h = true
	if 	target_velocity.x > 0:
		sprite.flip_h = false
		
	if Input.is_action_just_pressed("attack"):
		attack()
		
		
func attack() -> void:
	if is_attacking:
		return
	animation_player.play("attack_side1")
	attack_cooldown = 0.6
	is_attacking = true
		
		











