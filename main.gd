extends Node2D

@export var ball_scene: PackedScene

@onready var ball_spawn = $BallSpawn
@onready var hud = $HUD

var player_score = 0
var opponent_score = 0


func _ready():
	spawn_ball()


func spawn_ball():
	var ball = ball_scene.instantiate()

	ball.position = ball_spawn.position

	call_deferred("add_child", ball)


func _on_player_goal_ball_hit():
	opponent_score += 1
	hud.update_score(player_score, opponent_score)
	spawn_ball()


func _on_opponent_goal_ball_hit():
	player_score += 1
	hud.update_score(player_score, opponent_score)
	spawn_ball()
