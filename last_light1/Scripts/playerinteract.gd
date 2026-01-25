extends RayCast3D
@onready var crosshair = get_parent().get_parent().get_node("player_ui/CanvasLayer/crosshair")
func _physics_process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		var ui = get_tree().current_scene.get_node("proto_controller/player_ui")

		if hit.name == "note":
			crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				ui.advance_task(1, "Clue found! Now open the drawer.")
				hit.queue_free()
		if hit.name == "door":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
		elif hit.name == "drawer":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().toggle_door()
				if hit.is_in_group("firstd") and ui.current_task_id == 2:
					ui.advance_task(2, "Great! You found the clue. Now go to the kitchen.")
		else: 
			if crosshair.visible:
				crosshair.visible = false
	else:
		if crosshair.visible:
			crosshair.visible = false
