extends Control

@export var main_scene : PackedScene

func change_to_main() -> void:
	get_tree().change_scene_to_packed(main_scene)
