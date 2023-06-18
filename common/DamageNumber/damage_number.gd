extends Label

# x_range = Vector(Min range, max range)
var x_range := Vector2i(5, 5)
var y_range := Vector2i(10, 20)
var tween_time : float = 0.2

func _ready():
	var new_position = position + Vector2(
		randf_range(-x_range.y, x_range.y) + x_range.x,
		-1 * (randi() % y_range.y + y_range.x)	
	)

	scale = Vector2(0.4, 0.4)
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", new_position, tween_time)
	tween.parallel().tween_property(self, "scale", Vector2(1.2, 1.2), tween_time)
	tween.tween_property(self, "position", new_position + Vector2(0, 5), tween_time*2)
	tween.parallel().tween_property(self, "scale", Vector2(0.9, 0.8), tween_time)
	tween.parallel().tween_property(self, "modulate", Color(1,1,1,0), tween_time*2) # Color(1,1,1,0) = white with alpha equal to 0
	tween.tween_callback(queue_free)

