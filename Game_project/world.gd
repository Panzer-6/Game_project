extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen = OS.get_window_size()
var player = load("res://player.tscn")
var enemy = load("res://enemy.tscn")
var player_instance = player.instance()
var enemy_instance = enemy.instance()

var spawn_delay = 5
var spawn_delay_start = false
var spawn_delay_count = 0

var max_enemy_on_screen = 5
var current_enemy_on_screen = 0

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#add the player
	#---------------------------------------------------------------------------
	player_instance.position.x = screen.x / 2
	player_instance.position.y = screen.y * 3 / 4
	add_child(player_instance)
	#---------------------------------------------------------------------------
	
	#add the enemy
	#---------------------------------------------------------------------------
	enemy_instance.position.x = rand_range(screen.x / 4, (3 * screen.x) / 4)
	enemy_instance.position.y = rand_range(screen.y * 1 / 4, screen.y * 3 / 4)
	add_child(enemy_instance)
	current_enemy_on_screen += 1
	#---------------------------------------------------------------------------
	
	#spawning enemies continuously
	#---------------------------------------------------------------------------
	#if  :
	#	enemy_instance.position.x = rand_range(screen.x / 4, (3 * screen.x) / 4)
	#	enemy_instance.position.y = rand_range(screen.y * 1 / 4, screen.y / 2)
	#	add_child(enemy_instance)
	#---------------------------------------------------------------------------
	#enemy_instance.position.x = 5
	#enemy_instance.position.y = screen.y * 1 / 4
	#add_child(enemy_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child_count() - 3 < max_enemy_on_screen:
		#timer
		#---------------------------------------------------------------------------
		if spawn_delay_start == false:
			spawn_delay_count = 0
		else:
			spawn_delay_count += 1 * delta
		#---------------------------------------------------------------------------
		spawn_delay_start = true
		if spawn_delay_count >= spawn_delay:
			#add the enemy
			#-----------------------------------------------------------------------
			enemy_instance = enemy.instance()
			enemy_instance.position.x = rand_range(0, screen.x)
			enemy_instance.position.y = rand_range(screen.y * 1 / 4, screen.y / 2)
			add_child(enemy_instance)
			current_enemy_on_screen += 1
			#-----------------------------------------------------------------------
			spawn_delay_start = false
	if get_child_count() - 3 < current_enemy_on_screen:
		score += current_enemy_on_screen - (get_child_count() - 3)
		current_enemy_on_screen -= current_enemy_on_screen - (get_child_count() - 3)
		print(score)
	if score == 5:
		spawn_delay = 4.5
	if score == 10:
		spawn_delay = 4
	if score == 15:
		spawn_delay = 3.5
	if score == 20:
		spawn_delay = 3
	if score == 25:
		spawn_delay = 2.5
	if score == 30:
		spawn_delay = 2
	if score == 35:
		spawn_delay = 1.5
	if score == 40:
		spawn_delay = 1


