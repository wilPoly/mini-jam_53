extends Control

onready var level = preload("res://src/levels/Test_Level.tscn")
onready var play_button = $Buttons/Play/Play
onready var quit_button = $Buttons/Quit/Quit

func _ready() -> void:
	play_button.grab_focus()


func _on_Play_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to(level)


func _on_Quit_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().quit()
