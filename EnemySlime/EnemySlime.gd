extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var patrol_points = [] # List to store patrol points
var current_patrol_point_index = 0 # Index to keep track of current patrol point

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/WorldArtTesting/Player_Test")  # Adjust the path to your player character node
	if player:
		print("Player found:", player)
	else:
		print("Player not found!")
	
	# Define your patrol points here (adjust these values as needed)
	patrol_points = [
		Vector2(100, 100),
		Vector2(300, 100),
		Vector2(300, 300),
		Vector2(100, 300)
	]

func _physics_process(delta):
	var direction = Vector2.ZERO # Initialize direction vector
	if player_chase and player:
		direction = player.global_position - global_position
		direction = direction.normalized()  # Normalize the direction vector
		position += direction * speed * delta
		$AnimatedSprite2D.play("walk")
	else:
		# If not chasing player, move towards the next patrol point
		var patrol_point = patrol_points[current_patrol_point_index]
		direction = patrol_point - global_position
		direction = direction.normalized()  # Normalize the direction vector
		position += direction * speed * delta
		$AnimatedSprite2D.play("walk")
		
		# Check if slime reached the current patrol point
		if global_position.distance_to(patrol_point) < 10:
			current_patrol_point_index = (current_patrol_point_index + 1) % patrol_points.size() # Move to next patrol point
	
	# Flip sprite based on movement direction
	$AnimatedSprite2D.flip_h = direction.x > 0  # Flip sprite based on direction

func _on_detection_area_body_entered(body):
	if body.name == "PlayerCharacter":
		print("Player entered detection area")
		player = body
		player_chase = true

func _on_detection_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == player:
		player = null
		player_chase = false
		print("On Exit")
