extends State

class_name AttackState

var attack_direction = Vector2.ZERO
var attacking = false

@export var attack_duration = 0.15

@onready var attack_duration_timer = $"../../AttackDuration"
@onready var attack_cooldown_timer = $"../../AttackCooldown"
@onready var attack_buffer_timer = $"../../AttackBuffer"

func state_process(delta):
	character.apply_gravity(delta)
	if character.jump_input_just_pressed and character.current_jumps < character.max_jumps:
		next_state = states.Jump
	elif not attacking:
		next_state = states.Fall
		
func on_enter():
	attacking = true
	attack_duration_timer.start(attack_duration)
	character.anim_player.play("Attack")

func on_exit():
	attack_cooldown_timer.start(0.15)
	character.can_attack = false
	attacking = false


func _on_attack_duration_timeout():
	attacking = false
