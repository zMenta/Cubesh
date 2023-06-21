extends Label

func _ready() -> void:
	Gamestate.update_tooltip.connect(update_text)
	Gamestate.hide_tooltip.connect(hide_tooltip)


func update_text(new_text: String) -> void:
	show()
	text = "Press 'E' to " + new_text


func hide_tooltip() -> void:
	hide()
