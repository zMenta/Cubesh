extends Node

@export var map_pool : Array[PackedScene]

@onready var map := $Map

var enemy_counter : int = 0 : set = _set_enemy_counter
var map_counter : int = -1

func _set_enemy_counter(new_value: int) -> void:
	enemy_counter = new_value
	if enemy_counter == 0:
		enemy_counter = 0
		Gamestate.spawn_teleporter.emit()
		Gamestate.create_annoucement.emit("Somewhere a portal has been created..")
	elif enemy_counter == -1:
		enemy_counter = 0


func _ready() -> void:
	Gamestate.add_node_to_world.connect(_add_node_to_world)
	Gamestate.map_exited.connect(_map_changed)
	Gamestate.enemy_spawned.connect(_count_enemies)
	Gamestate.enemy_slain.connect(_enemy_defeated)
	Gamestate.player_died.connect(_on_player_death)
	_map_changed()


func _add_node_to_world(node: Node) -> void:
	map.add_child.call_deferred(node)


func _map_changed() -> void:
	map_counter += 1
	for node in map.get_children():
		node.queue_free()
	
	var next_map : TileMap = map_pool[map_counter].instantiate()
	map.add_child(next_map)

	
func _count_enemies() -> void:
	enemy_counter += 1

func _enemy_defeated() -> void:
	enemy_counter -= 1

func _on_player_death() -> void:
	enemy_counter = -1
	for node in map.get_children():
		node.queue_free()
	
	var next_map : TileMap = map_pool[map_counter].instantiate()
	map.add_child.call_deferred(next_map)
