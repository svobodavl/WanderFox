extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

signal can_see_player
signal disable_playerdetectionzone
signal enable_playerdetectionzone

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var BatCantSeePlayer = false
var PlayerDetectionZoneIsActive = true

var state = CHASE
var DetectionZone = load("PlayerDetectionZone")

onready var sprite = $Sprite
onready var stats = $Stats	
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtboxes
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	BatCantSeePlayer = false
	
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
				
		CHASE:
			var player = playerDetectionZone.player
			emit_signal("can_see_player")
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = pick_random_state([IDLE, WANDER])

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func seek_player():
	if PlayerDetectionZoneIsActive == true:
		if playerDetectionZone.can_see_player():
			state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtboxes_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_Hurtboxes_invincibility_started():
	animationPlayer.play("Start")

func _on_Hurtboxes_invincibility_ended():
	animationPlayer.play("Stop")

func bat_cant_see_player():
	PlayerDetectionZoneIsActive = false
	
func bat_can_see_player():
	PlayerDetectionZoneIsActive = true
