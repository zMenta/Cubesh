extends Node

signal add_node_to_world(node: Node)
signal map_exited()
signal update_tooltip(text: String)
signal hide_tooltip()
signal teleport_player(new_global_pos: Vector2)
signal weapon_pickup(new_weapon: Weapon)
signal health_changed(new_value: int)
signal stamina_changed(new_value: int)
signal create_annoucement(text: String)
signal spawn_teleporter()
signal enemy_spawned()
signal enemy_slain()

