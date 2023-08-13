extends Node2D

@export var ball_scene: PackedScene
@onready var ball_spawn = $BallSpawn


func _ready():
	spawn_ball()


func spawn_ball():
	var ball = ball_scene.instantiate()

	ball.position = ball_spawn.position

	add_child(ball)


func _on_player_goal_ball_hit():
	spawn_ball()
