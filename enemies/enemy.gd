extends CharacterBody2D

const ACCELERATION = 2
const FRICTION = 10

@export var speed = 10
@export var dash_speed = 230

@export var on_detection_cooldown : float = 1.0
@export var attack_cooldown : float = 3.0

@onready var hurtbox_shape : CollisionShape2D = $ComponentHurtbox/CollisionShape2D2

var target : Node2D


func _ready() -> void:
	Gamestate.enemy_spawned.emit()


func _physics_process(_delta: float) -> void:
	if target == null:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		velocity.y = move_toward(velocity.y, 0, FRICTION)
		return

	look_at(target.global_position)
	var direction = global_position.direction_to(target.global_position)
	velocity.x = move_toward(velocity.x, direction.x * speed, ACCELERATION)
	velocity.y = move_toward(velocity.y, direction.y * speed, ACCELERATION)
	move_and_slide()


func _dash() -> void:
	if target == null:
		return

	hurtbox_shape.disabled = false
	var timer = get_tree().create_timer(0.7)
	var direction = global_position.direction_to(target.global_position)
	velocity.x = move_toward(velocity.x, direction.x * dash_speed, dash_speed)
	velocity.y = move_toward(velocity.y, direction.y * dash_speed, dash_speed)
	await timer.timeout
	hurtbox_shape.disabled = true



func _on_detection_zone_body_entered(body:Node2D) -> void:
	target = body
	$AttackCooldown.start(on_detection_cooldown)


func _on_detection_zone_body_exited(body: Node2D) -> void:
	if target == body:
		target = null


func _on_attack_cooldown_timeout() -> void:
	$AnimationPlayer.play("attack")
	if target != null:
		$AttackCooldown.start(attack_cooldown)


func _on_component_health_died() -> void:
	Gamestate.enemy_slain.emit()
	queue_free()


func _on_component_health_attack_received(attack) -> void:
	var knockback_accel = 100
	var direction = global_position.direction_to(target.global_position) * -1
	velocity.x = move_toward(velocity.x, direction.x * attack.knockback, knockback_accel)
	velocity.y = move_toward(velocity.y, direction.y * attack.knockback, knockback_accel)

