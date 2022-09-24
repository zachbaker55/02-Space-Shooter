extends KinematicBody2D

var direction = Vector2(1.5,0)

var health = 1

var Effects = null
onready var Bullet = load("res://Enemy/Bullet.tscn")
onready var Explosion = load("res://Effects/Explosion.tscn")


func _process(delta):
	$Sprite.modulate = Global.enemyColor

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(200)
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.damage(100)
		damage(100)


func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	var distance = position.distance_to(Player.position); 
	if(distance <= 300):
		Effects = get_node_or_null("/root/Game/Effects")
		if Player != null and Effects != null:
			var bullet = Bullet.instance()
			var d = global_position.angle_to_point(Player.global_position) - PI/2
			bullet.rotation = d
			bullet.global_position = global_position + Vector2(0,-15).rotated(d)
			Effects.add_child(bullet)
		
