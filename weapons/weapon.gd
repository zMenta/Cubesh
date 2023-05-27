extends Sprite2D
class_name  Weapon

@export var attack : Attack
@export_enum("thrust_attack", "swing_attack") var attack_type = "thrust_attack"
@export var attack_speed_scale : float = 1
@export var collision_area := Area2D


func enable_collision() -> void:
	collision_area.monitoring = true


func disable_collision() -> void:
	collision_area.monitoring = false


func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.has_node("ComponentHealth"):
		var health : ComponentHealth = body.get_node("ComponentHealth")
		health.take_damage(attack.damage)
