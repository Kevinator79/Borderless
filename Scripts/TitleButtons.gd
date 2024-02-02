extends Node2D

var saveFound = false

@export var worldscene: String = "res://World/World.tscn"
const hover = preload("res://Sounds/hover.mp3")
const press = preload("res://Sounds/press.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	if not FileAccess.file_exists("user://savegame.save"):
		saveFound = false;
		setButtonStates()
		return # Error! We don't have a save to load..
	saveFound = true;
	setButtonStates()
	pass # Replace with function body.

func setButtonStates():
	$PlayBtn.visible = !saveFound;
	$Continue.visible = saveFound;
	$NewGame.visible = saveFound;


func _on_quit_button_pressed():
	get_tree().quit(0);

func _on_btn_mouse_entered():
	$AudioHover.play(0.0)


func _on_options_pressed():
	pass


func _on_button_down():
	$AudioClick.play(0.0)


func _on_play_btn_pressed():
	get_tree().change_scene_to_file(worldscene)
