extends Panel

@onready var label : Label = $Label
@onready var animation : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Gamestate.create_annoucement.connect(_announce)

func _announce(text: String) -> void:
	label.text = text
	animation.play("default")
	
