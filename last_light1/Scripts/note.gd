extends Node3D

@export var drawer_to_unlock : NodePath

func _on_body_entered(body):
	if body.name == "proto_controller":
		if drawer_to_unlock != NodePath():
			get_node(drawer_to_unlock).locked = false
		queue_free()
