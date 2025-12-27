extends State
class_name PlayerMove

var player: PlayerMain

func Enter():
	print("ENTERING STATE: Move")
	player = $"../.."

func Update(delta: float):
	if not player.is_on_floor():
		state_transition.emit(self, "Falling")
		return

	var input = Input.get_vector("left", "right", "up", "down")
	var dir = (player.head.transform.basis * player.transform.basis * Vector3(input.x, 0, input.y)).normalized()
	
	if Input.is_action_pressed("sprint"):
		player.speed = player.SPRINT_SPEED
	else:
		player.speed = player.WALK_SPEED

	player.velocity.x = lerp(player.velocity.x, dir.x * player.speed, delta * player.GROUND_ACCEL)
	player.velocity.z = lerp(player.velocity.z, dir.z * player.speed, delta * player.GROUND_ACCEL)

	player.t_bob += delta * player.velocity.length()
	player.camera.transform.origin = player._headbob(player.t_bob)

	var vel_len = clamp(player.velocity.length(), 0.5, player.SPRINT_SPEED * 2)
	var target_fov = player.BASE_FOV + player.FOV_CHANGE * vel_len
	player.camera.fov = lerp(player.camera.fov, target_fov, delta * 8.0)

	player.move_and_slide()

	if input.length() == 0:
		state_transition.emit(self, "Idle")
	elif Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
