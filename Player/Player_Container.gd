extends Node2D

onready var Player = load("res://Player/Player.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var player = Player.instance()
		player.position = Vector2(Global.VP.x/2,Global.VP.y/2)
		var HUD = get_node_or_null("/root/Game/UI/HUD")
		if HUD != null:
			HUD.update_health(Global.startHealth)
		add_child(player)
