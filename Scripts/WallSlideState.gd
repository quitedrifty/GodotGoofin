extends State

class_name WallSlideState

func state_process(delta):
	
	character.velocity.y = 200
	if character.is_grounded():
		next_state = states.Idle
	elif not character.is_against_wall():
		next_state = states.Fall
	elif character.movement_input == Vector2.DOWN:
		character.dropping = true
		next_state = states.Fall
	elif character.jump_input_just_pressed:
		next_state = states.Jump
	elif character.dash_input and character.can_dash:
		character.dashed_in_air = true
		next_state = states.Dash
	elif character.attack_input and character.can_attack:
		next_state = states.Attack	

func on_enter():
	character.current_jumps -= 1
	
	if character.face_wall() > 0:
		character.player_sprite.flip_h = false
	elif character.face_wall() < 0:
		character.player_sprite.flip_h = true
		
	character.anim_player.play("WallSlide")

func on_exit():
	character.can_wall_slide = false
