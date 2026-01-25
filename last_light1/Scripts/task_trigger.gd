extends Area3D
@export var tasktxt: String
@export var trigger_id: int
var triggered = false
var ui

func _ready():
	ui = get_tree().current_scene.get_node("proto_controller/player_ui")

func enter_trigger(body):
	if body.name == "proto_controller" and !triggered:
		if ui.current_task_id == trigger_id:
			triggered = true
			ui.advance_task(trigger_id, tasktxt)
