extends Control

@export var titleScene= "res://Interface/MainMenu.tscn";
@export var world= "res://World/World.tscn";
const hover = preload("res://Sounds/hover.mp3")
const press = preload("res://Sounds/press.mp3")

func _on_btn_mouse_entered():
	$AudioHover.play(0.0)

func _on_button_down():
	$AudioClick.play(0.0)

func _on_play_again_pressed():
	get_tree().change_scene_to_file(world)

func _on_titleScreen_pressed():
	get_tree().change_scene_to_file(titleScene)

func _on_quit_pressed():
	get_tree().quit(0);
