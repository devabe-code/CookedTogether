extends CharacterBase
class_name PlayerMain

@onready var fsm = $FiniteStateMachine

@export var SENSITIVITY = 0.004
@export var BASE_FOV = 75.0

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
const MIN_JUMP_VELOCITY = 2.4
const MAX_JUMP_VELOCITY = 9.8

const AIR_ACCEL = 0.6
const AIR_CONTROL = 0.5
const GROUND_ACCEL = 14.0
const BUNNY_HOP_GRAVITY = 32.0

const MAX_JUMP_HOLD_TIME = 0.3
const JUMP_HOLD_FORCE = 30.0

const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

const FOV_CHANGE = 1.5

var gravity = 70.8
var is_jumping = false
var jump_timer = 0.0

@onready var head = $Head
@onready var camera = $Head/FirstPersonCamera
@onready var debug_camera = $DebugViewPort/SubviewPort/DebugCam

var current_anim := ""

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Smooth follow debug cam
	var cam_target = global_transform.origin + Vector3(0, 5, -10)
	debug_camera.global_transform.origin = debug_camera.global_transform.origin.lerp(cam_target, delta * 5.0)
	debug_camera.look_at(global_transform.origin + Vector3(0, 2, 0), Vector3.UP)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
