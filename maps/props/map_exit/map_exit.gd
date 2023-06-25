extends Sprite2D

@export var exit_game := false

func _on_interactable_area_interacted() -> void:
	if exit_game == false:
		Gamestate.map_exited.emit()
	else:
		get_tree().quit()

