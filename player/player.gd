extends CharacterBody2D

@export var current_weapon : Weapon
@onready var animation := $AnimationPlayer

const SPEED = 150
const ACCELERATION = 20
const FRICTION = 25

 
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack") and current_weapon != null:
		animation.speed_scale = current_weapon.attack_speed_scale
		animation.play(current_weapon.attack_type)


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2():
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION)
		velocity.y = move_toward(velocity.y, direction.y * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		velocity.y = move_toward(velocity.y, 0, FRICTION)

	look_at(get_global_mouse_position())
	move_and_slide()


func _enable_weapon_collision() -> void:
	if not current_weapon is Weapon:
		return
	current_weapon.enable_collision()

func _disable_weapon_collision() -> void:
	if not current_weapon is Weapon:
		return
	current_weapon.disable_collision()
