extends State
class_name PlayerIdle

@export var animator : AnimationPlayer
var player: PlayerMain

func Enter():
	print("ENTERING STATE: Idle")
	player = $"../.."

func Update(_delta: float):
	if not player.is_on_floor():
		state_transition.emit(self, "Falling")
	elif Input.get_vector("left", "right", "up", "down").length() > 0:
		state_transition.emit(self, "Moving")
	elif Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jumping")
