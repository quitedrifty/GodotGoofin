extends StaticBody2D

var spindirection = 1
var spinspeed = PI
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += spindirection*spinspeed*delta
	
func Parried():
	spindirection *= -1
	spinspeed += 0.2
	
