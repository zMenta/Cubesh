extends Node
class_name ComponentHealth

signal died

@export var create_blood_on_hit : bool = true
@export var max_health : int = 100
@onready var current_health := max_health
@onready var blood: PackedScene = preload("res://common/blood/blood.tscn")


func take_damage(value: int) -> void:
	_create_damage_taken_effect()
	current_health = clampi(current_health - value, 0, max_health)
	if current_health <= 0:
		died.emit()


func _create_damage_taken_effect() -> void:
	if create_blood_on_hit == false:
		return

	var new_blood : Node2D = blood.instantiate()
	new_blood.global_position = get_parent().global_position
	new_blood.rotation = get_parent().rotation + deg_to_rad(randf_range(-40, 40)) + deg_to_rad(180)
	Gamestate.add_node_to_world.emit(new_blood)

	