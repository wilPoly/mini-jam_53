extends KinematicBody2D

signal picked_up

export var speed := 150

var velocity : Vector2
var can_pickup := false
var item_local : Node
var inventory := {}


func _process(delta: float) -> void:
	_pickup(item_local)


func _physics_process(delta: float) -> void:
	velocity = _movement() * speed * delta
	move_and_collide(velocity)
	
func _movement() -> Vector2:
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if abs(velocity.x) == 1 and abs(velocity.y) == 1:
		velocity = velocity.normalized()
		return velocity
	return velocity
	
	
func _pickup(item) -> void:
	if can_pickup:
		if Input.is_action_just_pressed("ui_accept"):
			print(item.item_type)
			_update_inventory(item)
			emit_signal("picked_up")


func _update_inventory(item) -> void:
	if inventory.has(item.item_type):
		inventory[item.item_type] += item.quantity
	else:
		inventory[item.item_type] = item.quantity
	print(inventory)
	

func on_pickup_entered(item) -> void:
	item_local = item
	can_pickup = true
	connect("picked_up", item, "on_pickup")
	
func on_pickup_exited(item) -> void:
	can_pickup = false
	disconnect("picked_up", item, "on_pickup")
