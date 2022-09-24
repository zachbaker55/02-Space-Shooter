extends Node

var VP = null
var GP = null

var score = 0;
var startTime = 999
var startLives = 3
var startHealth = 3;

var time = startTime
var lives = startLives

var backHue = 0.2
var enemyHue = 0.0
var bulletHue = 0.7
var playerHue = 0.5
var backColor;
var enemyColor;
var bulletColor;
var playerColor;


func _ready():
	randomize()
	pause_mode = Node.PAUSE_MODE_PROCESS
	VP = get_viewport().size
	GP = Vector2(1024,1024)
	var _signal = get_tree().get_root().connect("size_changed",self,"_resize")
	reset() 

func _process(delta):
	if backHue >= 1:
		backHue = 0;
	if enemyHue >= 1:
		enemyHue = 0;
	if bulletHue >= 1:
		bulletHue = 0;
	if playerHue >= 1:
		playerHue = 0;
	backColor = Color.from_hsv(backHue, 0.5, 0.9, 1)
	enemyColor = Color.from_hsv(enemyHue, 0.5, 0.9, 1)
	bulletColor = Color.from_hsv(bulletHue, 0.5, 0.9, 1)
	playerColor = Color.from_hsv(playerHue, 0.5, 0.9, 1)
	VisualServer.set_default_clear_color(backColor)
	backHue += 0.01 * delta;
	enemyHue += 0.01 * delta;
	bulletHue += 0.01 * delta;
	playerHue += 0.01 * delta;


func _physics_process(_delta):
	var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Asteroid_Container != null and Enemy_Container != null:
		if Asteroid_Container.get_child_count() == 0 and Enemy_Container.get_child_count() == 0:
			var _scene = get_tree().change_scene("res://UI/End_Game.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var Pause_Menu = get_node_or_null("/root/Game/UI/Pause_Menu")
		if Pause_Menu == null:
			get_tree().quit()
		else:
			if Pause_Menu.visible:
				Pause_Menu.hide()
				get_tree().paused = false
			else:
				Pause_Menu.show()
				get_tree().paused = true

func _resize():
	#VP = get_viewport().size
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_lives()

func update_score(s):
	score += s
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_score()

func update_lives(l):
	lives += l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var HUD = get_node_or_null("/root/Game/UI/HUD")
		if HUD != null:
			HUD.update_lives()

func reset():
	score = 0
	time = startTime
	lives = startLives
	backHue = 0.2
	enemyHue = 0.0
	bulletHue = 0.7
	playerHue = 0.5
