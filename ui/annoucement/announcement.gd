extends Label

@onready var animation : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Gamestate.create_annoucement.connect(_announce)

func _announce(new_text: String) -> void:
	text = new_text
	animation.play("default")
	
