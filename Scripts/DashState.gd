extends State

class_name DashState

var dash_direction = Vector2.ZERO
var dash_speed = 2240
var dashing = false

@export var dash_duration = 0.15
@onready var dash_duration_timer = $"../../DashDuration"
@onready var dash_cooldown_timer = $"../../DashCooldown"

func state_process(delta):
	if character.jump_input_just_pressed:
		next_state = states.Jump
	elif not dashing:
		next_state = states.Fall
	
func on_enter():
	character.can_dash = false
	dashing = true
	dash_duration_timer.start(dash_duration)
	if character.movement_input.x != Vector2.ZERO.x:
		dash_direction = Vector2(character.movement_input.x, 0)
	else:
		dash_direction = Vector2.RIGHT if character.player_sprite.flip_h else Vector2.LEFT
	character.velocity = dash_direction * dash_speed
	character.anim_player.play("Dash")
	
func on_exit():
	dashing = false
	dash_cooldown_timer.start(0.1)
	
func _on_dash_duration_timeout():
	dashing = false
	dash_cooldown_timer.start(0.1)
