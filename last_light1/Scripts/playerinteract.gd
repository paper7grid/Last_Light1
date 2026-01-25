extends RayCast3D
@onready var crosshair = get_parent().get_parent().get_node("player_ui/CanvasLayer/crosshair")
@onready var note_open =  get_parent().get_node("player_ui/note_open")
@onready var player_ui = get_node("player_ui")
func _physics_process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		#var ui = get_tree().current_scene.get_node("proto_controller/player_ui")

		if hit.name == "note":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				player_ui.show_note()
				# ui.advance_task(1, "Check the drawer in the room for a clue.")
				#hit.queue_free()
		elif hit.name == "door":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
		elif hit.name == "drawer":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().toggle_door()
				if hit.is_in_group("firstd") and player_ui.current_task_id == 2:
					player_ui.advance_task(2, "Great! You found the clue. Now go to the kitchen.")
		else: 
			if crosshair.visible:
				crosshair.visible = false
	else:
		if crosshair.visible:
			crosshair.visible = false
