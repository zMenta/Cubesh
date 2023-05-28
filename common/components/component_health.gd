extends Node
class_name ComponentHealth

signal died
signal damage_taken

@export var max_health : int = 100
@onready var current_health := max_health


func take_damage(value: int) -> void:
    damage_taken.emit()
    current_health = clampi(current_health - value, 0, max_health)
    if current_health <= 0:
        died.emit()