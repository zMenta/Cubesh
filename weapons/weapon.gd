extends Sprite2D
class_name  Weapon

@export_enum("thrust_attack", "swing_attack") var attack_type = "thrust_attack"
@export var attack_speed_scale : float = 1

@onready var hurtbox_shape : CollisionShape2D = $ComponentHurtbox/CollisionShape2D


func enable_collision() -> void:
	hurtbox_shape.disabled = false


func disable_collision() -> void:
	hurtbox_shape.disabled = true
