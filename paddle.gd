extends Area2D

@export var is_player = false
@export var speed = 700.0
@export var acceleration = 1800.0
@export var friction = 1000.0

@onready var collision_shape_2d = $CollisionShape2D
@onready var screen_size = get_viewport_rect().size
@onready var height = collision_shape_2d.shape.extents.y

var velocity = Vector2.ZERO
var direction = 0


func _process(delta):
	if is_player:
		set_player_velocity()
	else:
		set_opponent_velocity()

	move(delta)


func set_player_velocity():
	direction = 0

	if Input.is_action_pressed("move_up"):
		direction = -1
	if Input.is_action_pressed("move_down"):
		direction = 1

	if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up"):
		velocity.y = speed / 4 * direction
	if Input.is_action_just_released("move_down") or Input.is_action_just_released("move_up"):
		velocity.y = velocity.y / 2


func set_opponent_velocity():
	var balls = get_tree().get_nodes_in_group("Ball")

	if balls.size() == 0:
		return

	var ball = balls[0]
	var target_y = 0
	var previous_direction = direction
	direction = 0

	if ball.velocity.x < 0:
		target_y = screen_size.y / 2
	else:
		target_y = ball.position.y

	var padding = height / 2
	if abs(target_y - position.y) <= padding:
		direction = 0
	elif target_y < position.y:
		direction = -1
	elif target_y > position.y:
		direction = 1

	if direction != previous_direction and direction != 0:
		velocity.y = speed / 4 * direction
	if direction != previous_direction and direction == 0:
		velocity.y = velocity.y / 2


func move(delta):
	if direction != 0:
		velocity.y = move_toward(velocity.y, direction * speed, acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, direction, friction * delta)

	position += velocity * delta
	position.y = clamp(position.y, height, screen_size.y - height)
