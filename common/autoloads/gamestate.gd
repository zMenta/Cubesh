extends Node

signal add_node_to_world(node: Node)
signal map_exited()
signal update_tooltip(text: String)
signal hide_tooltip()
signal teleport_player(new_global_pos: Vector2)
signal weapon_pickup(new_weapon: Weapon)

