extends Node

@onready var map := $TileMap


func _ready() -> void:
	Gamestate.add_node_to_world.connect(_add_node_to_world)


func _add_node_to_world(node: Node) -> void:
	map.add_child(node)
