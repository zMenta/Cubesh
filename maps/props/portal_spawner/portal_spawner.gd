extends Marker2D

@export var portal_scene : PackedScene

func _ready() -> void:
	hide()
	Gamestate.spawn_teleporter.connect(_spawn_portal)


func _spawn_portal() -> void:
	var portal := portal_scene.instantiate()
	portal.global_position = global_position
	Gamestate.add_node_to_world.emit(portal)

