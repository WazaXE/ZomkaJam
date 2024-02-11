extends CharacterBody2D
@export var speed = 400

func _process(_delta):
	var animation = "idle"
	move_and_collide(velocity * _delta)
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
		animation = "walk-LR"
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		animation = "walk-LR"
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = 0

	if Input.is_action_pressed("down"):
		velocity.y += 1
		animation = "down"
	elif Input.is_action_pressed("up"):
		velocity.y -= 1
		animation = "up"
	else:
		velocity.y = 0

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	#Set Animation
	$AnimatedSprite2D.animation = animation
		

	

