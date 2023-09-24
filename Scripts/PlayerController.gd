extends CharacterBody2D


@export var anim_player : AnimationPlayer

@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var wall_slide_cooldown = $WallSlideCooldown
@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var left_ground_raycast = $LeftGroundRaycast
@onready var right_ground_raycast = $RightGroundRaycast

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2

#player input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_just_pressed = false
var attack_input = false 
var attack_input_released = true
var dash_input = false

#player_movement
const SPEED : float = 700.0
const JUMP_VELOCITY : float = -1200.0

var last_direction = Vector2.RIGHT

#mechanics
var can_dash = true
var dashed_in_air = false
var can_attack = true
var jump_buffered = false
var was_on_floor = false
var coyote_time = false
var max_jumps = 2
var current_jumps = 0
var wall_direction = 1






func _physics_process(delta):
	
#	move_direction = -int(Input.is_action_pressed("left")) + int(Input.is_action_pressed("right"))
#	if character_state_machine.check_if_can_move():
#		if move_direction < 0:
#			player_sprite.scale.x = -0.308
#		else:
#			player_sprite.scale.x = 0.308
##		velocity.x = lerp(velocity.x, speed*move_direction, 0.2)
#
##		for snapper movement, use below code instead of above
#
#		var direction = Input.get_axis("left", "right")
#		if direction:
#			velocity.x = move_direction * speed
#		else:
#			velocity.x = move_toward(velocity.x, 0, speed)
	if is_grounded():
		was_on_floor = true
		dashed_in_air = false

	player_input()
	floor_snap_length = 10.0
	move_and_slide()

func apply_gravity(delta):
	if not is_grounded():
		velocity.y += gravity * delta
		
func apply_movement():
	if coyote_time:
		movement_input.y = 0
	if movement_input.x > 0:
		velocity.x = SPEED
		player_sprite.flip_h = false
		last_direction = Vector2.RIGHT
	elif movement_input.x < 0:
		velocity.x = - SPEED
		player_sprite.flip_h = true
		last_direction = Vector2.LEFT
	else:
		velocity.x = 0

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("right"):
		movement_input.x += 1
	if Input.is_action_pressed("left"):
		movement_input.x -= 1
	if Input.is_action_pressed("up"):
		movement_input.y -= 1
	if Input.is_action_pressed("down"):
		movement_input.y += 1
	# jumps
	if Input.is_action_pressed("jump"):
		jump_input = true
	else: 
		jump_input = false
		
	if Input.is_action_just_pressed("jump"):
		jump_input_just_pressed = true
	else: 
		jump_input_just_pressed = false
	
	#attack
	if Input.is_action_pressed("attack") and attack_input_released:
		attack_input_released = false
		attack_input = true
	else: 
		attack_input = false
	
	if Input.is_action_just_released("attack"):
		attack_input_released = true
	#dash
	if Input.is_action_just_pressed("dash"):
		dash_input = true
	else: 
		dash_input = false

func flip():
	player_sprite.flip_h = last_direction == Vector2.RIGHT
	
func _on_dash_cooldown_timeout():
	if not dashed_in_air:
		can_dash = true


func _on_jump_buffer_timeout():
	jump_buffered = false


func _on_attack_cooldown_timeout():
	can_attack = true


func _on_coyote_timer_timeout():
	coyote_time = false
	
func is_grounded():
	if left_ground_raycast.is_colliding() or right_ground_raycast.is_colliding():
		print("ground")
		return true
	print("air")
	return false
