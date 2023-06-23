extends Node2D

@export var weapon_scene : PackedScene

@onready var interact_zone : InteractableArea = $InteractableArea

var weapon : Weapon


func _ready() -> void:
	if weapon == null:
		weapon = weapon_scene.instantiate()

	interact_zone.tooltip_text = "pickup " + weapon.name
	add_child(weapon)


func _on_interactable_area_interacted() -> void:
	if weapon is Weapon:
		Gamestate.weapon_pickup.emit(weapon)
	queue_free()

