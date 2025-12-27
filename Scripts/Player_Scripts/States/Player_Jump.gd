extends State
class_name PlayerJump

enum JumpPhase { START, MIDAIR, LANDING }

var player: PlayerMain
var jump_dir := Vector3.ZERO

# Adjusted constants for tight jumping
const HOLD_FORCE := 10.0
const HOLD_TIME_LIMIT := 0.15

func Enter():
	player = $"../.."
	player.is_jumping = true

func Update(delta: float):
	# Start Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = player.MIN_JUMP_VELOCITY
		player.is_jumping = true
		player.jump_timer = 0.0

	# Hold Jump
	if player.is_jumping and Input.is_action_pressed("jump") and player.jump_timer < player.MAX_JUMP_HOLD_TIME:
		player.velocity.y += player.JUMP_HOLD_FORCE * delta
		player.jump_timer += delta
