extends Area2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@export_file("*.tscn") var level: String


func _ready():
	sprite_2d.visible = false
	collision_shape_2d.set_deferred("disabled", true)

func open_portal():
	sprite_2d.visible = true
	collision_shape_2d.set_deferred("disabled", false)

func _on_body_entered(body):
	if body.has_method("player"):
		call_deferred("_remove_collision_object", body)

func _remove_collision_object(body):
	body.queue_free()
	get_tree().change_scene_to_file(level)
