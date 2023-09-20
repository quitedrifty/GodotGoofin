extends State

class_name AttackState

var attack_direction = Vector2.ZERO
var attacking = false

@export var attack_duration = 0.15

@onready var attack_duration_timer = $"../../AttackDuration"

func state_process(delta):
	character.velocity = Vector2.ZERO
	if character.jump_input_just_pressed:
		next_state = states.Jump
	elif not attacking:
		next_state = states.Fall
		
func on_enter():
	attacking = true
	attack_duration_timer.start(attack_duration)
	character.anim_player.play("Attack")

func on_exit():
	attacking = false


func _on_attack_duration_timeout():
	attacking = false
