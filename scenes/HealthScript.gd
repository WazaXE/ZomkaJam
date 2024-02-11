extends Camera2D

var player = null

# Health nodes
var health_A
var health_B
var health_C
var health_D

# Camera settings
var camera_zoom = 8.0
var camera_offset = Vector2(0, 0)

func _ready():
	# Set camera properties
	#zoom = camera_zoom # faking causeing errors

	offset = camera_offset

	# Find the player node
	player = get_node("/root/WorldArtTesting/PlayerNode")  # Adjust the path to your player character node
	if player:
		print("Player found:", player)
	else:
		print("Player not found!")

	# Check for Health_A node
	health_A = get_node("/root/WorldArtTesting/Health_A")
	if health_A:
		print("Health_A found:", health_A)
	else:
		print("Health_A not found!")

	# Check for Health_B node
	health_B = get_node("/root/WorldArtTesting/Health_B")
	if health_B:
		print("Health_B found:", health_B)
	else:
		print("Health_B not found!")

	# Check for Health_C node
	health_C = get_node("/root/WorldArtTesting/Health_C")
	if health_C:
		print("Health_C found:", health_C)
	else:
		print("Health_C not found!")

	# Check for Health_D node
	health_D = get_node("/root/WorldArtTesting/Health_D")
	if health_D:
		print("Health_D found:", health_D)
	else:
		print("Health_D not found!")

	# Make sure all health nodes are initially visible
	if health_A:
		health_A.visible = true
	if health_B:
		health_B.visible = true
	if health_C:
		health_C.visible = true
	if health_D:
		health_D.visible = true

# Collision with enemies
func _on_Player_body_entered(body):
	if body.is_in_group("EnemySlime"):
		# Decrease player health and toggle visibility of health nodes
		if health_D and health_D.visible:
			health_D.visible = false
		elif health_C and health_C.visible:
			health_C.visible = false
		elif health_B and health_B.visible:
			health_B.visible = false
		elif health_A and health_A.visible:
			health_A.visible = false
