extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/Effect Scenes/EnemyDeathEffect.tscn")

var player = null
var move = Vector2.ZERO
var SPEED = 1500

onready var deathTimer = $DeathTimer
onready var stats = $Stats
onready var hurtbox = $Hurtboxes

func _ready():
	deathTimer.start()

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null:
		move = position.direction_to(player.position) * SPEED
	else:
		move = Vector2.ZERO
		
	move = move.normalized()
	move = move_and_collide(move)
func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body

func _on_DeathTimer_timeout():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
