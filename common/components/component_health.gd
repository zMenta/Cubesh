extends Node
class_name ComponentHealth

signal died
signal attack_received(attack: Attack)

@export var create_blood_on_hit : bool = true
@export var max_health : int = 100
@onready var current_health := max_health
@onready var blood: PackedScene = preload("res://common/blood/blood.tscn")
@onready var damage_number: PackedScene = preload("res://common/DamageNumber/damage_number.tscn")


func take_damage(attack: Attack) -> void:
	attack_received.emit(attack)
	_create_damage_taken_effect()
	_create_damage_number(str(attack.damage))
	current_health = clampi(current_health - attack.damage, 0, max_health)
	if current_health <= 0:
		died.emit()


func restore(amount: int) -> void:
	current_health = clampi(current_health + amount, 0, max_health)
	_create_damage_number("+" + str(amount))


func _create_damage_taken_effect() -> void:
	if create_blood_on_hit == false:
		return

	var new_blood : Node2D = blood.instantiate()
	new_blood.global_position = get_parent().global_position
	new_blood.rotation = get_parent().rotation + deg_to_rad(randf_range(-40, 40)) + deg_to_rad(180)
	Gamestate.add_node_to_world.emit(new_blood)


func _create_damage_number(text: String) -> void:
	var dmg_num : Label = damage_number.instantiate()
	dmg_num.text = text
	dmg_num.global_position = get_parent().global_position
	Gamestate.add_node_to_world.emit(dmg_num)
	
