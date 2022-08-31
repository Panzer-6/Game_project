extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 500

var blink_cooldown = false
var fire_cooldown = false
var special_cooldown = false

var bullet = preload("res://Bullet.tscn")
var special = preload("res://Special.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var motion = Vector2()
	
	#Direction of movement
	if Input.is_action_pressed("up"):
		motion.y = -1
	if Input.is_action_pressed("down"):
		motion.y = 1
	if Input.is_action_pressed("left"):
		motion.x = -1
	if Input.is_action_pressed("right"):
		motion.x = 1
		
		
	motion = motion.normalized()
	if Input.is_action_just_pressed("blink") && not blink_cooldown:
		motion = move_and_slide(motion * speed * 25)
		blink_cooldown = true
		yield(get_tree().create_timer(1),"timeout") #Blink cooldown
		blink_cooldown = false
	else:
		motion = move_and_slide(motion * speed)
	
	#look_at(Vector2(0, 1))
	
	if Input.is_action_pressed("fire") && not fire_cooldown:
		fire()
		fire_cooldown = true
		yield(get_tree().create_timer(0.1),"timeout") 
		fire_cooldown = false
		
	#if Input.is_action_just_pressed("special") && not special_cooldown:
	#	fire_special()
	#	special_cooldown = true
	#	yield(get_tree().create_timer(1),"timeout") 
	#	special_cooldown = false

func fire():
	var bullet_instance = bullet.instance()
	#add_child_below_node(get_node("world"), bullet_instance)
	bullet_instance.position = get_global_position()
	bullet_instance.position.y -= 50
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
#func fire_special():
#	var special_instance = special.instance()
#	special_instance.position = get_global_position()
#	special_instance.rotation_degrees = rotation_degrees
#	special_instance.apply_impulse(Vector2(), Vector2(special_speed, 0).rotated(rotation))
#	get_tree().get_root().call_deferred("add_child", special_instance)
	
func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "enemy" in body.name:
		kill()
