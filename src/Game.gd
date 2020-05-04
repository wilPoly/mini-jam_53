extends Node

#onready var gui = preload("res://src/gui/GUI.tscn").instance()
onready var next_level = preload("res://src/levels/Test_Level.tscn").instance()


func _ready() -> void:
#	call_deferred("load_node", gui)
#	call_deferred("load_node", next_level)
	pass

func load_node(node: Node) -> void:
	get_parent().add_child(node)
