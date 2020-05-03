extends Node2D

signal sandstorm
signal objective_completed

export (String, MULTILINE) var objective


func _ready() -> void:
	pass

func _on_EventTimer_timeout() -> void:
	print("Sandstorm !")
