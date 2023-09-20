extends State

class_name RunState

func state_process(delta):
	character.apply_gravity(delta)
	character.apply_movement()
	
	if character.movement_input.x == 0:
		next_state = states.Idle
	elif character.velocity.y > 0:
		next_state = states.Fall
	elif character.jump_input_just_pressed:
		next_state = states.Jump
	elif character.dash_input and character.can_dash:
		next_state = states.Dash
	elif character.attack_input and character.can_attack:
		next_state = states.Attack
	elif character.attack_input:
		next_state = states.Attack
		
func on_enter():
	character.current_jumps = 0
	character.flip()
	character.anim_player.play("Run")

func state_input(event : InputEvent):
	pass
#	if event.is_action_pressed("jump"):
#		jump()
#	if event.is_action_pressed("dash"):
#		dash()
#	if event.is_action_pressed("attack"):
#		attack()	
#	if event.is_action_pressed("parry"):
#		parry()	
#	if event.is_action_pressed("special_attack"):
#		special_attack()
