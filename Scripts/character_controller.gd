extends CharacterBody2D

@export var SPEED = 600.0
@export var JUMP_VELOCITY = -1200.0
@export var MAX_JUMPS = 2
@export var currentJumps = 0
@export var DASH_SPEED = 5500.0
@export var MAX_DASH= 2
@export var currentDash = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*2
var _parried_object
var timer
var isParrying
var isDashing
var dashdirection
var dashtimer = 0.1
var dashacc =0
var attackRight
var attackLeft
var attackUp
var attackDown
var attacktimer=0.2
var attackacc = 0

func _ready():
	timer = get_node("Timer")
	timer.timeout.connect(_parry_timer_timeout)
	
	
func _physics_process(delta):
	
	if isDashing:
		velocity= Vector2(dashdirection.x*DASH_SPEED,dashdirection.y*DASH_SPEED)
		dashacc += delta
		
		if dashacc>dashtimer:
			isDashing = false
			dashdirection = null
			dashacc=0
			
	else:
		if attackRight:
			$RightAttackArea/Sprite2D.visible = not $RightAttackArea/Sprite2D.visible
			attackacc += delta
			if attackacc>attacktimer:
				attackacc=0
				attackRight = false
				$RightAttackArea/Sprite2D.visible = false
		if attackLeft:
			$LeftAttackArea/Sprite2D.visible = not $LeftAttackArea/Sprite2D.visible
			attackacc += delta
			if attackacc>attacktimer:
				attackacc=0
				attackLeft = false
				$LeftAttackArea/Sprite2D.visible = false
		if attackUp:
			$UpAttackArea/Sprite2D.visible = not $UpAttackArea/Sprite2D.visible
			attackacc += delta
			if attackacc>attacktimer:
				attackacc=0
				attackUp = false
				$UpAttackArea/Sprite2D.visible = false
		if attackDown:
			$DownAttackArea/Sprite2D.visible = not $DownAttackArea/Sprite2D.visible
			attackacc += delta
			if attackacc>attacktimer:
				attackacc=0
				attackDown = false
				$DownAttackArea/Sprite2D.visible = false
		# Add the gravity.
		if not is_on_floor() and not isDashing:
			velocity.y += gravity * delta

		if is_on_floor():
			currentJumps=0

		if is_on_wall():
			currentJumps -= 1
		# Handle Jump.
		if Input.is_action_just_pressed("jump"):
			if Input.is_action_pressed("down"):
				position.y +=1
			else:
				if currentJumps<MAX_JUMPS:
					velocity.y = JUMP_VELOCITY
					currentJumps+=1

		if Input.is_action_just_pressed("dash") and currentDash<MAX_DASH:
			if Input.is_action_pressed("left"):
				isDashing = true
				dashdirection = Vector2(-1, 0)
			if Input.is_action_pressed("right"):
				isDashing = true
				dashdirection = Vector2(1, 0)

		if Input.is_action_just_pressed("attack"):
			var vec = Input.get_vector("left","right","up","down")
			if vec == Vector2.ZERO:
				attackRight=true
			else:
				if abs(vec.x) > abs(vec.y):
					if vec.x < 0:
						attackLeft=true
					else:
						attackRight=true
				else:
					if vec.y < 0:
						attackUp=true
					else:
						attackDown=true
		if Input.is_action_just_pressed("parry"):
			timer.start()
			isParrying = true


		if isParrying:
			visible = not visible

			if _parried_object != null:
				_parried_object.Parried()
				isParrying=false
				
				
		var direction = -int(Input.is_action_pressed("left")) + int(Input.is_action_pressed("right"))
		velocity.x = lerp(velocity.x, SPEED*direction, 0.2)
#		for snapper movement, use below code instead of above

#		var direction = Input.get_axis("left", "right")
#		if direction:
#			velocity.x = direction * SPEED
#		else:
#			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

	
func _on_wheel_parry_box_body_exited(body):
	print("ASDF")
	_parried_object = null

func _on_wheel_parry_box_body_entered(body):
	print("ASDF")
	_parried_object = get_parent().get_node("Wheel")

func _parry_timer_timeout():
	isParrying = false
	visible = true
	
	
