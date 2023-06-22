extends Sprite2D

func _on_interactable_area_interacted() -> void:
	Gamestate.map_exited.emit()

