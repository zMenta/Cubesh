extends Node

@export var map_pool : Array[PackedScene]

@onready var map := $Map

var map_counter : int = 0


func _ready() -> void:
	Gamestate.add_node_to_world.connect(_add_node_to_world)
	Gamestate.map_exited.connect(_map_changed)


func _add_node_to_world(node: Node) -> void:
	map.add_child(node)


func _map_changed() -> void:
	map_counter += 1
	for node in map.get_children():
		node.queue_free()
	
	var next_map : TileMap = map_pool[map_counter].instantiate()
	map.add_child(next_map)

	
