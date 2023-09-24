extends State

class_name FallState

@onready var jump_buffer_timer = $"../../JumpBuffer"

func state_process(delta):
	character.apply_gravity(delta)
	character.apply_movement()
	
	if character.jump_input_just_pressed:
		if character.current_jumps < character.max_jumps:
			next_state = states.Jump
		else:
			character.jump_buffered = true
			jump_buffer_timer.start(0.2)
	elif character.velocity.y == 0:
		if character.jump_buffered:
			character.current_jumps = 0
			next_state = states.Jump
		else:
			next_state = states.Idle
	elif character.is_against_wall() and character.can_wall_slide:
		next_state = states.WallSlide
	elif character.dash_input and character.can_dash:
		character.dashed_in_air = true
		next_state = states.Dash
	elif character.attack_input and character.can_attack:
		next_state = states.Attack
	
func state_input(event : InputEvent):
	pass
	
func on_enter():
	if not character.dropping:
		character.can_wall_slide = true
	character.anim_player.play("Fall")

func on_exit():
	character.dropping = false
