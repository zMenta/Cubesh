extends Marker2D

func _ready() -> void:
	hide()
	Gamestate.teleport_player.emit(global_position)

