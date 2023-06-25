extends Marker2D

@export var portal_scene : PackedScene

func _ready() -> void:
	Gamestate.spawn_teleporter.connect(_spawn_portal)


func _spawn_portal() -> void:
	add_child(portal_scene.instantiate())

