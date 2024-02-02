extends TextureRect

class_name DialogBox

signal dialog_started
signal dialog_ended

@onready var dialog_text = $dialog_text
var current_dialog = []
var current_index = 0

func _ready():
	Dialogs.dialog_box = self
	hide()
	current_index = 0

func show_dialog(dialog):
	current_dialog = dialog
	current_index = 0
	update_dialog_text()
	show()
	dialog_text.show()
	emit_signal("dialog_started")

func update_dialog_text():
	var text = ""
	if current_index <= len(current_dialog):
		text = current_dialog[current_index-1] + "\n"
		current_index += 1
	else:
		hide_dialog()
	dialog_text.text = text

func hide_dialog():
	hide()
	emit_signal("dialog_ended")

func _input(event):
	if event.is_action_pressed("ui_up") and current_dialog.size() > 0:
		if current_index <= len(current_dialog):
			update_dialog_text()
		else:
			hide_dialog()
