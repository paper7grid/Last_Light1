extends Area3D
@onready var ui = get_tree().current_scene.get_node("proto_controller/player_ui")
@export var tasktxt: String
var triggered = false

func enter_trigger(body):
	if body.name == "proto_controller" and !triggered:
		triggered = true
		ui.set_task(tasktxt)
	
