extends Control


onready var play_button = $Buttons/Play
onready var quit_button = $Buttons/Quit
onready var game = get_parent()

func _ready() -> void:
	play_button.grab_focus()


func _on_Play_focus_entered() -> void:
	play_button.set_scale(Vector2(1.5, 1.5))
	print(play_button.has_focus())


func _on_Play_focus_exited() -> void:
	play_button.set_scale(Vector2(1, 1))


func _on_Quit_focus_entered() -> void:
	quit_button.set_scale(Vector2(1.5, 1.5))


func _on_Quit_focus_exited() -> void:
	quit_button.set_scale(Vector2(1, 1))


func _on_Play_gui_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		game.load_node()
