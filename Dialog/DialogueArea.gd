extends Area2D

var active = false

@export var character_name: String = "Nameless NPC"
@export var dialog = []
enum speaking_type {SPEAK, SHOP, QUEST}
@export var type: speaking_type

var current_dialog = -1

func _input(event):
	
	if not active or Dialogs.active or not event.is_action_pressed("ui_up"):
		return
	
	if dialog.size() < 1 or dialog[0] == "":
		return
	
	if type == speaking_type.SPEAK:
		if dialog.size() > 0:
			Dialogs.show_dialog(dialog)
		
	if type == speaking_type.SHOP:
		push_error("Shop is not setup yet")
		return
	if type == speaking_type.QUEST:
		push_error("Quest is not setup yet idk if this will be on time anyways gonna focus more on enemy fighting.")
		return
	pass

func _on_body_entered(body):
	if body is CharacterBody2D:
		active = true

func _on_body_exited(body):
	if body is CharacterBody2D:
		active = false
