extends Node2D

var stream : AudioStreamPlayer
var song : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	stream = $AreaIntro
	song = $BossMusic
	song.stop()
	stream.stop()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		if !stream.playing:
			stream.play()


func _on_area_2d_2_body_entered(body):
	if body is CharacterBody2D:
		if !song.playing:
			stream.stop()
			song.play()
			
		
