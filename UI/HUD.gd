extends Control

var lives_pos = Vector2.ZERO
var lives_index = 15
onready var Indicator = load("res://UI/Indicator.tscn")
var health_pos = Vector2.ZERO
var healh_index = 15
onready var Health = load("res://UI/Health.tscn")

func _ready():  
	update_score()
	update_time()
	update_lives()
	update_health(Global.startHealth)
	
	
func update_score():
	$Score.text = "Score: " + str(Global.score)
	
func update_time():
	$Time.text = "Time Remaining: " + str(Global.time)

func update_lives(): 
	lives_pos = Vector2(15,Global.VP.y-20)
	for child in $Indicator_Container.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var indicator = Indicator.instance()
		indicator.position = Vector2(lives_pos.x+i*lives_index,lives_pos.y)
		$Indicator_Container.add_child(indicator)

func update_health(healthVal): 
	lives_pos = Vector2(15,Global.VP.y -5)
	for child in $Health_Container.get_children():
		child.queue_free()
	for i in range(healthVal):
		var health = Health.instance()
		health.position = Vector2(lives_pos.x+i*lives_index,lives_pos.y)
		$Health_Container.add_child(health)

func _on_Timer_timeout():
	Global.time -= 1
	if Global.time < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:	
		update_time()
	
