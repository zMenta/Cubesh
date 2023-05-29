extends CharacterBody2D


const SPEED = 10
const ACCELERATION = 2
const FRICTION = 10
const DASH_SPEED = 230

var target : Node2D
@onready var hurtbox_shape : CollisionShape2D = $ComponentHurtbox/CollisionShape2D2

func _physics_process(_delta: float) -> void:
	if target == null:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		velocity.y = move_toward(velocity.y, 0, FRICTION)
		return

	look_at(target.global_position)
	var direction = global_position.direction_to(target.global_position)
	velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, direction.y * SPEED, ACCELERATION)
	move_and_slide()


func _on_component_health_died() -> void:
	queue_free()


func _dash() -> void:
	if target == null:
		return

	hurtbox_shape.disabled = false
	var timer = get_tree().create_timer(0.7)
	var direction = global_position.direction_to(target.global_position)
	velocity.x = move_toward(velocity.x, direction.x * DASH_SPEED, DASH_SPEED)
	velocity.y = move_toward(velocity.y, direction.y * DASH_SPEED, DASH_SPEED)
	await timer.timeout
	hurtbox_shape.disabled = true



func _on_detection_zone_body_entered(body:Node2D) -> void:
	target = body
	$AttackCooldown.start()


func _on_detection_zone_body_exited(body: Node2D) -> void:
	if target == body:
		target = null


func _on_attack_cooldown_timeout() -> void:
	$AnimationPlayer.play("attack")
	if target != null:
		$AttackCooldown.start()
