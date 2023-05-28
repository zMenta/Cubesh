extends CharacterBody2D

var blood: PackedScene


func _ready() -> void:
	blood = preload("res://common/blood/blood.tscn")


func _on_component_health_died() -> void:
	queue_free()


func _on_component_health_damage_taken() -> void:
	var new_blood: Sprite2D = blood.instantiate()
	new_blood.global_position = global_position
	Gamestate.add_node_to_world.emit(new_blood)