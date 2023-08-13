extends Area2D

@export var is_player_goal: bool = false
@onready var collision_shape_2d = $CollisionShape2D

signal ball_hit


func _ready():
	var screen_size = get_viewport_rect().size

	collision_shape_2d.shape.extents = Vector2(16, screen_size.y)


func _on_area_entered(area):
	if area.is_in_group("Ball"):
		emit_signal("ball_hit")
		area.queue_free()
