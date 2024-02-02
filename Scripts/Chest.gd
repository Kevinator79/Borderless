extends Area2D

@onready var sprite = $sprite
@onready var hitbox = $hitbox
@onready var player = $"../../EntityLayer/Player"

func _ready():
	sprite.visible = false
	hitbox.set_deferred("disabled", true)

func spawn_chest():
	sprite.visible = true
	hitbox.set_deferred("disabled", false)

func _on_body_entered(body):
	if body.has_method("player"):
		for n in 10:
			var coin = preload("res://Items/Item.tscn").instantiate()
			player.collect(coin.item)
		queue_free()
