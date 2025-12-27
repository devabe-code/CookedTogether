extends State
class_name PlayerFall

var player: PlayerMain

func Enter():
	player = $"../.."
	print("ENTERING STATE: Fall")

func Update(delta: float):
	# Apply gravity
	player.velocity.y -= player.BUNNY_HOP_GRAVITY * delta

	# Optional: Air strafing
	var input = Input.get_vector("left", "right", "up", "down")
	if input.length() > 0.01:
		var dir = (player.head.transform.basis * player.transform.basis * Vector3(input.x, 0, input.y)).normalized()
		player.velocity.x = lerp(player.velocity.x, dir.x * player.speed, delta * player.AIR_ACCEL * player.AIR_CONTROL)
		player.velocity.z = lerp(player.velocity.z, dir.z * player.speed, delta * player.AIR_ACCEL * player.AIR_CONTROL)

	player.move_and_slide()

	# Land
	if player.is_on_floor():
		if input.length() > 0:
			state_transition.emit(self, "Moving")
		else:
			state_transition.emit(self, "Idle")
