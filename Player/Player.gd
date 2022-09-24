extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 1.0
var max_speed = 50.0
var health = Global.startHealth;
var dead = false; 

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

onready var Bullet = load("res://Player/Bullet.tscn")
var nose = Vector2(0,-15)



func _ready():
	position.x = Global.GP.x/2
	position.y = Global.GP.y/2
	
func _process(delta):
	$Sprite.modulate = Global.playerColor
	$Exhaust.modulate = Global.bulletColor
	

func _physics_process(_delta):
	if dead == false:
		velocity = velocity + get_input()*speed
		velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
		velocity = move_and_slide(velocity, Vector2.ZERO)
		position.x = wrapf(position.x, 0, Global.GP.x)
		position.y = wrapf(position.y, 0, Global.GP.y)
		if Input.is_action_just_pressed("shoot"):
			Effects = get_node_or_null("/root/Game/Effects")
			if Effects != null:
				var bullet = Bullet.instance()
				bullet.global_position = global_position + nose.rotated(rotation)
				bullet.rotation = rotation
				Effects.add_child(bullet)



func get_input():
	if dead == false:
		var to_return = Vector2.ZERO
		$Exhaust.hide()
		if Input.is_action_pressed("forward"):
			to_return.y -= 1
			$Exhaust.show()
		if Input.is_action_pressed("left"):
			rotation_degrees = rotation_degrees - rotation_speed
		if Input.is_action_pressed("right"):
			rotation_degrees = rotation_degrees + rotation_speed
		return to_return.rotated(rotation)
	
func damage(d):
	if dead == false:
		health -= d
		if health <= 0:
			Global.update_lives(-1)
			Effects = get_node_or_null("/root/Game/Effects")
			if Effects != null:
				var explosion = Explosion.instance()
				Effects.add_child(explosion)
				explosion.global_position = global_position
				dead = true;
				hide()
				yield(explosion, "animation_finished")
			queue_free()
		else:
			var HUD = get_node_or_null("/root/Game/UI/HUD")
			if HUD != null:
				HUD.update_health(health)
				
func bounce():
	velocity = move_and_slide(-velocity, Vector2.ZERO)

func _on_Area2D_body_entered(body):
	if dead == false:
		if body.name != "Player" and body.name != "Level":
			damage(Global.startHealth)
			
