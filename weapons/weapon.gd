extends Sprite2D
class_name  Weapon

@export var attack := Attack.new()
@export var collision_area := Area2D


func enable_collision() -> void:
	collision_area.monitoring = true


func disable_collision() -> void:
	collision_area.monitoring = false
