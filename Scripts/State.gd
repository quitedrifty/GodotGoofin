extends Node

class_name State

var character : CharacterBody2D
var next_state : State
var states : Dictionary

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass
	
func on_enter():
	pass

func on_exit():
	pass
