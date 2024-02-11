extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var patrol_points = [] # List to store patrol points
var current_patrol_point_index = 0 # Index to keep track of current patrol point

# Looks for player
func _ready():
	player = get_node("/root/WorldArtTesting/PlayerNode")  # Adjust the path to your player character node
	if player:
		print("Player found:", player)
	else:
		print("Player not found!")
	
	
	patrol_points = [
		Vector2(100, 100),
		Vector2(300, 100),
		Vector2(300, 300),
		Vector2(100, 300)
	]

func _physics_process(delta):
	
	move_and_slide() #FAKING BULLSHIT THIS IS JUST COLLITION!
	
	var direction = Vector2.ZERO # Initialize direction vector
	if player_chase and player:
		direction = player.global_position - global_position
		if direction.length() > 10: # Move only if the player is not very close
			direction = direction.normalized()  # Normalize the direction vector
			position += direction * speed * delta
			$AnimatedSprite2D.play("walk")
	else:
		# If not chasing player, move towards the next patrol point
		var patrol_point = patrol_points[current_patrol_point_index]
		direction = patrol_point - global_position
		if direction.length() < 10: # Check if slime reached the current patrol point
			current_patrol_point_index = (current_patrol_point_index + 1) % patrol_points.size() # Move to next patrol point
		else:
			direction = direction.normalized()  # Normalize the direction vector
			position += direction * speed * delta
			$AnimatedSprite2D.play("walk")
	
	$AnimatedSprite2D.flip_h = direction.x > 0  

func _on_detection_area_body_entered(body):
	if body.name == "PlayerNode":  
		print("Player entered detection area")
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body.name == "PlayerNode":  
		print("Player exited detection area")
		player_chase = false
		player = null
		# Reset the patrol behavior
		current_patrol_point_index = 0 #NOT WORKING


func _on_camera_2d_2_visibility_changed():
	pass # Replace with function body.
