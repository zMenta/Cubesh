extends Area2D
class_name InteractableArea

signal interacted

@export var tooltip_text : String = "tooltip"
var can_interact := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(_body:Node2D) -> void:
	Gamestate.update_tooltip.emit(tooltip_text)
	can_interact = true


func _on_body_exited(_body:Node2D) -> void:
	Gamestate.hide_tooltip.emit()
	can_interact = false


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		interacted.emit()

