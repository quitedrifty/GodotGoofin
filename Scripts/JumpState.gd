extends State

class_name JumpState

func state_process(delta):
	character.apply_gravity(delta)
	character.apply_movement()
	if character.velocity.y > 0:
		next_state = states.Fall
	elif character.velocity.y == 0:
		next_state = states.Idle
	elif character.jump_input_just_pressed and character.current_jumps < character.max_jumps:
		next_state = states.Jump
	elif character.dash_input and character.can_dash:
		next_state = states.Dash
	elif character.attack_input and character.can_attack:
		next_state = states.Attack
		
func state_input(event : InputEvent):
	pass
	
func on_enter():
	character.velocity.y = character.JUMP_VELOCITY
	character.current_jumps += 1
	character.anim_player.stop()
	character.anim_player.play("Jump")
