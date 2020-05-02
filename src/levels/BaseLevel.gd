extends Node2D

signal sandstorm


func _ready() -> void:
	pass

func _on_EventTimer_timeout() -> void:
	print("Sandstorm !")
