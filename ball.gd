extends Area2D

@export var speed = 400.0
@onready var collision_shape_2d = $CollisionShape2D
@onready var screen_size = get_viewport_rect().size

var velocity = Vector2.ZERO


func _ready():
	apply_initial_velocity()


func _physics_process(delta):
	check_wall_hit()

	position += velocity * delta


func apply_initial_velocity():
	rotation = PI / 4 + randf_range(-PI / 4, PI / 4)
	velocity = Vector2(-speed, speed)
	velocity = velocity.rotated(rotation)


func check_wall_hit():
	if (
		position.x <= collision_shape_2d.shape.radius
		or position.x + collision_shape_2d.shape.radius >= screen_size.x
	):
		velocity.x *= -1

	if (
		position.y <= collision_shape_2d.shape.radius
		or position.y + collision_shape_2d.shape.radius >= screen_size.y
	):
		velocity.y *= -1


func _on_area_entered(area):
	if area.is_in_group("Paddle"):
		if (
			(velocity.x < 0 and position.x > area.position.x)
			or (velocity.x > 0 and position.x < area.position.x)
		):
			velocity.x *= -1
		else:
			velocity.y *= -1

		velocity.y = velocity.y + area.velocity.y / 2
