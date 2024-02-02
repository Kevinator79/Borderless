extends Area2D


var item_scene = preload("res://Items/ChestItem.tscn")

@export var item_type: String = "Coin"
@export var amount: int = 1


func spawn():
	var item = item_scene.instance()
	$ItemSpawn.get_parent().add_child(item)
	item.item_type = item_type
	item.amount = amount
	item.position = $ItemSpawn.global_position
	pass


func _on_body_entered(body):
	if body is CharacterBody2D:
		spawn()
		body_entered.disconnect(_on_body_entered)
		queue_free()
	
