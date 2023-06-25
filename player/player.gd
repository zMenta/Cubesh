extends CharacterBody2D

@export var current_weapon : Weapon
@export var dash_particle_scene : PackedScene

@onready var animation := $AnimationPlayer
@onready var weapon_slot := $WeaponSlot

const SPEED = 150
const ACCELERATION = 20
const FRICTION = 25
const DASH_SPEED = 450

func _ready() -> void:
	Gamestate.teleport_player.connect(func(new_pos): global_position = new_pos) 
	Gamestate.weapon_pickup.connect(_pickup_weapon)

 
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

	if Input.is_action_just_pressed("dodge"):
		_dash(direction)

	look_at(get_global_mouse_position())
	move_and_slide()


func _dash(direction: Vector2) -> void:
	var particle = dash_particle_scene.instantiate()
	add_child(particle)
	velocity.x = move_toward(velocity.x, direction.x * DASH_SPEED, DASH_SPEED)
	velocity.y = move_toward(velocity.y, direction.y * DASH_SPEED, DASH_SPEED)


func _enable_weapon_collision() -> void:
	if not current_weapon is Weapon:
		return
	current_weapon.enable_collision()


func _disable_weapon_collision() -> void:
	if not current_weapon is Weapon:
		return
	current_weapon.disable_collision()


func _on_component_health_died() -> void:
	print("died")


func _pickup_weapon(new_weapon: Weapon) -> void:
	if current_weapon != null:
		var item_drop = preload("res://maps/props/item_drop/item_drop.tscn").instantiate()
		item_drop.weapon = current_weapon.duplicate()
		item_drop.global_position = global_position
		Gamestate.add_node_to_world.emit(item_drop)

	for child in weapon_slot.get_children():
		child.queue_free()

	current_weapon = new_weapon
	weapon_slot.add_child(current_weapon)
	
