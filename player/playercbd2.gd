extends CharacterBody2D

const speed = 100.0
var player_state

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right","up","down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	velocity = direction * speed
	move_and_slide()
	play_anim(direction)

func play_anim(dir):
	
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	elif player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("up")
		if dir.x == 1:
			
			$AnimatedSprite2D.play("walking")
			$AnimatedSprite2D.flip_h = false
		if dir.y == 1:
			$AnimatedSprite2D.play("down")
		if dir.x == -1:
			$AnimatedSprite2D.play("walking")
			$AnimatedSprite2D.flip_h = true
		
