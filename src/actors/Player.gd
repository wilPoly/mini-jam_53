extends KinematicBody2D

signal health_changed
signal item_picked_up

signal picked_up

export (int) var speed := 150
export (float) var health = 100.0
export (float) var health_max := 100.0
export (float) var thirst_damage := -10.0

var velocity : Vector2
var can_pickup := false
var item_local : Node
var inventory := {}


func _ready() -> void:
	$DeathTimer.start()
	connect("health_changed", $"../HUD", "on_health_changed")
	connect("item_picked_up", $"../HUD", "on_item_picked_up")


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
	
	
func _pickup(item: Node) -> void:
	if can_pickup:
		if Input.is_action_just_pressed("ui_accept"):
			print(item.item_type)
			_update_inventory(item)
			emit_signal("picked_up")
			_update_health(item.damage)


func _update_inventory(item: Node) -> void:
	if inventory.has(item.item_type):
		inventory[item.item_type] += item.quantity
	else:
		inventory[item.item_type] = item.quantity
	emit_signal("item_picked_up", inventory)
	

func _update_health(health_change: float) -> void:
	var new_health = health + health_change
	health = min(new_health, health_max)
#	print("Player's health: ", health)
	emit_signal("health_changed", health)


func _on_DeathTimer_timeout() -> void:
	_update_health(thirst_damage)


func on_health_change(health_change: float):
	_update_health(health_change)
	

func on_pickup_entered(item) -> void:
	item_local = item
	can_pickup = true
	connect("picked_up", item, "on_pickup")
	
	
func on_pickup_exited(item) -> void:
	can_pickup = false
	disconnect("picked_up", item, "on_pickup")


func on_oasis_entered(oasis) -> void:
	$DeathTimer.stop()

func on_oasis_exited(oasis) -> void:
	$DeathTimer.start()
