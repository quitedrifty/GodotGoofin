extends State

class_name WallSlideState

func state_process(delta):
	
	character.velocity.y = 500
	if character.is_on_floor():
		next_state = states.Idle
	if not character.is_on_wall():
		next_state = states.Fall
	
func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		if not Input.is_action_pressed("down"):
			jump()
		else:
			drop()
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("attack"):
		attack()	
	if event.is_action_pressed("parry"):
		parry()	
	if event.is_action_pressed("special_attack"):
		special_attack()

func on_enter():
	get_parent().anim_player.play("WallSlide")

func on_exit():
	character.wall_slide_cooldown.start()

func jump():
	character.velocity.y = character.jump_velocity
	next_state = states.Jump

func drop():
	pass

func dash():
	pass
	
func attack():
	pass
	
func parry():
	pass
	
func special_attack():
	pass

