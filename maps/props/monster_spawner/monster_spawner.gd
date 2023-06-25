extends Marker2D

@export var monster : PackedScene

func _ready() -> void:
	hide()
	var enemy := monster.instantiate()
	enemy.global_position = global_position
	Gamestate.add_node_to_world.emit(enemy)

