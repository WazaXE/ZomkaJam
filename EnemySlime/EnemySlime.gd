extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/WorldArtTesting/Player")  # Adjust the path to your player character node
	#if player:
		#print("Player found:", player)
	#else:
		#print("Player not found!")

func _physics_process(delta):
	#print("Player:", player)
	if player_chase and player:
		var direction = player.global_position - global_position
		direction = direction.normalized()  # Normalize the direction vector
		position += direction * speed * delta
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = direction.x < 0  # Flip sprite based on direction (optional)
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	if body.name == "PlayerCharacter":
		print("Player entered detection area")
		player = body
		player_chase = true

func _on_detection_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == player:
		player = null
		player_chase = false


func _on_player_body_entered(body):
	pass # Replace with function body.
