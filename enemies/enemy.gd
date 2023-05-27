extends CharacterBody2D

func _on_component_health_died() -> void:
	queue_free()
