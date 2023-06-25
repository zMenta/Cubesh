extends ProgressBar

func _ready() -> void:
	Gamestate.health_changed.connect(_hp_changed)

func _hp_changed(new_value: int) -> void:
	value = new_value
