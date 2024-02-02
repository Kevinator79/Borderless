extends Node

signal dialog_started
signal dialog_ended

var active = false

var dialog_box = null: set = _set_dialog_box



func show_dialog(text:Array):
	dialog_box.show_dialog(text)
		

func _set_dialog_box(node):
	
	if not node is Node:
		push_error("provided node doesn't extend Node")
		return
	
	dialog_box = node
	
	if dialog_box.get_script().has_script_signal("dialog_started"):
		dialog_box.dialog_started.connect(_on_dialog_started)
	else:
		push_error("provided node doesn't implement dialog_started signal")
	
	if dialog_box.get_script().has_script_signal("dialog_ended"):
		dialog_box.dialog_ended.connect(_on_dialog_ended)
	else:
		push_error("provided node doesn't implement dialog_started signal")


func _on_dialog_started():
	active = true
	emit_signal("dialog_started")
	
func _on_dialog_ended():
	active = false
	emit_signal("dialog_ended")

