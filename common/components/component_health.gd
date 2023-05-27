extends Node
class_name ComponentHealth

signal died

@export var max_health : int = 100
@onready var current_health := max_health


func take_damage(value: int) -> void:
    current_health = clampi(current_health - value, 0, max_health)
    if current_health <= 0:
        died.emit()