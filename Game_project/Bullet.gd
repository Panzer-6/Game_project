extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2() 
var delete_delay = 0.05
var delete_delay_start = false
var delete_delay_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

	
func _physics_process(delta):
	#timer
	#---------------------------------------------------------------------------
	if delete_delay_start == false:
		delete_delay_count = 0
	else:
		delete_delay_count += 1 * delta
	#---------------------------------------------------------------------------
	if position.y > OS.get_window_size().y:
		queue_free()
	velocity.y = -50
	#move_and_slide(velocity)
	
	var collide = move_and_collide(velocity)
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




	

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Timer_timeout():
	pass # Replace with function body.
