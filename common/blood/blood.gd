extends Sprite2D

const SPRITE_SIZE := 16
var blood_sprites := Vector2i(4,3)


func _ready() -> void:
	z_index = 5
	scale = Vector2(0.4, 0.4)
	rotation_degrees = randf_range(0, 360)
	var animation_time := 0.16
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	var final_scale = Vector2(randf_range(1, 1.5), randf_range(1, 1.5))

	tween.tween_property(self, "position",
		position + Vector2(randf_range(15, 30), randf_range(-20, 20)),
		animation_time)
	tween.set_parallel(true).tween_property(self, "scale", final_scale, animation_time)
	await tween.finished

	z_index = -5


func _set_random_sprite() -> void:
	print(region_rect.position)

