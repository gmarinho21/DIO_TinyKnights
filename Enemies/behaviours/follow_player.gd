extends Node

@export var speed:float = 1
var enemy: Enemy
var sprite: AnimatedSprite2D

var input_vector: Vector2 = Vector2(0,0)



func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")
	pass

func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	var player_position = GameManager.player_position
	var difference = player_position - enemy.position
	input_vector = difference.normalized()
	
	enemy.velocity = input_vector * speed * 100
	rotate_sprite()
	enemy.move_and_slide()


func rotate_sprite() -> void:
	# Girar o sprite
	if 	input_vector.x < 0:
		sprite.flip_h = true
	if 	input_vector.x > 0:
		sprite.flip_h = false
