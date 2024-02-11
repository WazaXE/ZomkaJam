extends CharacterBody2D


const speed = 100.0
var dir : Vector2

func _physics_process(_delta: float):
	velocity = dir * speed
	move_and_slide()
	
	 
func  _unhandled_input(_event: InputEvent):
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	dir = dir.normalized()
