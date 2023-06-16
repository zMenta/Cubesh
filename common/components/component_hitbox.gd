extends Area2D
class_name ComponentHitbox

@export var health : ComponentHealth

func _ready() -> void:
    area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
    if not area is ComponentHurtbox:
        return

    health.take_damage(area.attack)
    
