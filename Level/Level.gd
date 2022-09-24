extends Node2D


func _process(delta):
	$Sprite.modulate = Global.enemyColor
	
func _on_Area2D_body_entered(body):
	if body.has_method("bounce"):
		body.bounce()
