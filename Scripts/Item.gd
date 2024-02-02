extends Area2D

@export var type: String = "Coin"
@export var amount: int = 1

@export var item: InvItem
var player = null

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		body_entered.disconnect(_on_body_entered)
		Inventory.add_Item(type, amount)
		
		player = body
		player.collect(item)
		
		queue_free()
	
