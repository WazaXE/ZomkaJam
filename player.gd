extends Area2D

@export var speed = 200
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.

	if Input.is_action_pressed("move_right"): #Returns true if pressed
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0: #If the player is moving play animation
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0: #Not standing still
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# If moving less than zero (left) then flip sprite
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if velocity.y < 0: 
		$AnimatedSprite2D.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
		
