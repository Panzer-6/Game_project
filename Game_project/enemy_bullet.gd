extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2() 
var delete_delay = 0.05
var delete_delay_start = false
var delete_delay_count = 0

var polar_coodinate = Vector2()
var polar_r = 0
var polar_q = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	
	if delete_delay_start == false:
		delete_delay_count = 0
	else:
		delete_delay_count += 1 * delta
	if position.y > OS.get_window_size().y:
		queue_free()
		
	#velocity.y = 50
	#polar coordinate
	#---------------------------------------------------------------------------
	polar_r = 5
	polar_q = 3.1416 / 2
	polar_coodinate.x = polar_r * cos(polar_q)
	polar_coodinate.y = polar_r * sin(polar_q)
	#---------------------------------------------------------------------------
	#move_and_slide(velocity)
	
	var collide = move_and_collide(polar_coodinate)
	#if velocity.x == 0 and velocity.y == 0:
	#	queue_free()
	#yield(get_tree().create_timer(0.05),"timeout")
	#queue_free()
	if collide:
		delete_delay_start = true
		if delete_delay_count >= delete_delay:
			print("hit")
			queue_free()
			delete_delay_start = false
