extends Node2D

onready var next_level = preload("res://src/levels/Test_Level.tscn").instance()


func _ready() -> void:
	call_deferred("load_level", next_level)

func load_level(level) -> void:
	get_parent().add_child(level)
