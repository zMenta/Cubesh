extends Area2D

@export var annoucement: String

var first_time := true

func _on_body_entered(_body:Node2D) -> void:
	if first_time == true:
		first_time = false
		Gamestate.create_annoucement.emit(annoucement)

