extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 1
var motion = Vector2()
var speed = 100
var enemy_bullet = preload("res://enemy_bullet.tscn")
var bullet_speed = 20
var fire_delay = 1
var fire_delay_start = false
var fire_delay_count = 0
var polar_coodinate = Vector2()
var polar_r = 0
var polar_q = 0
var rand = rand_range(-10, 10)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _physics_process(delta):
	#moving left and right
	#---------------------------------------------------------------------------
	#rand.randi_range(-1, 1)
	motion.x = rand
	if position.x >= OS.get_window_size().x - 10 or position.x <= 10:
		speed = -speed
	motion = move_and_slide(motion * speed)
	#---------------------------------------------------------------------------
	#xy to polar coordinate
	#---------------------------------------------------------------------------
	
	#---------------------------------------------------------------------------
	#timer
	#---------------------------------------------------------------------------
	if fire_delay_start == false:
		fire_delay_count = 0
	else:
		fire_delay_count += 1 * delta
	#---------------------------------------------------------------------------
	var player = get_parent().get_node("player")
	#position += (player.position - position)/50
	#look_at(player.position)
	#if not fire_cooldown:
	#	fire()
	#	fire_cooldown = true
	#	yield(get_tree().create_timer(0.25),"timeout") 
	#	fire_cooldown = false
	#if fire_delay_start == false:
		#fire()
	fire_delay_start = true
		
	if fire_delay_count >= fire_delay:
		fire()
		fire_delay_start = false
	
	
func fire():
	var enemy_bullet_instance = enemy_bullet.instance()
	#add_child_below_node(get_node("world"), bullet_instance)
	enemy_bullet_instance.position = get_global_position()
	enemy_bullet_instance.position.y += 50
	get_tree().get_root().call_deferred("add_child", enemy_bullet_instance)
	
	#move_and_slide(motion)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		health = health - 1
		if health <= 0:
			print("enemy destroyed")
			queue_free()
	if "Special" in body.name:
		health = health - 5
		if health <= 0:
			queue_free()
