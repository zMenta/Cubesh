extends Node2D

@export var restore_amount : int = 20

var player : CharacterBody2D


func _on_interactable_area_body_entered(body:Node2D) -> void:
	player = body


func _on_interactable_area_interacted() -> void:
	player.find_child("ComponentHealth").restore(restore_amount)
	queue_free()

