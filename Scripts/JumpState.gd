extends State

class_name JumpState

func state_process(delta):
	if not character.jump_input:
		character.apply_gravity(delta*1.5)
	character.apply_gravity(delta)
	character.apply_movement()
	if character.velocity.y > 0:
		next_state = states.Fall
	elif character.is_against_wall() and character.can_wall_slide:
		next_state = states.WallSlide
	elif character.velocity.y == 0:
		next_state = states.Idle
	elif character.jump_input_just_pressed and character.current_jumps < character.max_jumps:
		next_state = states.Jump
	elif character.dash_input and character.can_dash:
		character.dashed_in_air = true
		next_state = states.Dash
	elif character.attack_input and character.can_attack:
		next_state = states.Attack
		
func state_input(event : InputEvent):
	pass
	
func on_enter():
	character.wall_slide_timer.start(0.1)
	character.velocity.y = character.JUMP_VELOCITY
	
	if character.character_state_machine.previous_state == states.WallSlide:
		print("HER")
		character.velocity.x = character.face_wall() * character.SPEED
	character.current_jumps += 1
	character.anim_player.stop()
	character.anim_player.play("Jump")
