extends KinematicBody2D

export var speed := 150

var velocity : Vector2

func _physics_process(delta: float) -> void:
	velocity = movement() * speed * delta
	move_and_collide(velocity)
	
func movement() -> Vector2:
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if abs(velocity.x) == 1 and abs(velocity.y) == 1:
		velocity = velocity.normalized()
		return velocity
	return velocity
