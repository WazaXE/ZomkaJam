extends Area2D
signal hit #This signals that collider "hit" and enemy. Detect Collision

@export var speed = 200
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var animation = "idle"

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		animation = "walk-LR"
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		animation = "walk-LR"
		$AnimatedSprite2D.flip_h = true

	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		animation = "down"
	elif Input.is_action_pressed("move_up"):
		velocity.y -= 1
		animation = "up"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()

	$AnimatedSprite2D.animation = animation

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func _on_detection_area_body_entered(body):
	emit_signal("hit", body)
	print("Enemy and Player Colliding")
