extends State

class_name IdleState

func state_process(delta):
	if character.jump_input_just_pressed:
		next_state = states.Jump
	elif character.movement_input.x != 0:
		next_state = states.Run
	elif character.dash_input and character.can_dash:
		next_state = states.Dash
	elif character.velocity.y > 0:
		next_state = states.Fall
	elif character.attack_input:
		next_state = states.Attack
func state_input(event : InputEvent):
	pass
#	if event.is_action_pressed("jump") and not Input.is_action_pressed("down"):
#		jump()
#	if event.is_action_pressed("dash"):
#		dash()
#	if event.is_action_pressed("attack"):
#		attack()	
#	if event.is_action_pressed("parry"):
#		parry()	
#	if event.is_action_pressed("special_attack"):
#		special_attack()

func on_enter():
	character.current_jumps = 0
	character.anim_player.play("Idle")
