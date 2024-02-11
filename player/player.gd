extends Area2D

@export var speed = 200
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	#connect("body_entered", self, "_on_body_entered")
	#connect("body_exited", self, "_on_body_exited")

func _physics_process(delta):
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

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	$AnimatedSprite2D.animation = animation

func _on_body_entered(body):
	print("Body entered:", body.name)

func _on_body_exited(body):
	print("Body exited:", body.name)
