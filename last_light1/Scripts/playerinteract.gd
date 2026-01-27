extends RayCast3D
@onready var player_ui = get_parent().get_parent().get_node("player_ui")
@onready var door_s = get_tree().current_scene.get_node_or_null("door_sound")
@onready var drawer_s = get_tree().current_scene.get_node_or_null("drawer_opend")
@onready var note_sound = get_tree().current_scene.get_node_or_null("paper_note")

@onready var crosshair = get_parent().get_parent().get_node("player_ui/CanvasLayer/crosshair")
func _ready():
	# Debug prints to check if nodes are found
	print("RayCast3D ready!")
	print("player_ui found: ", player_ui != null)
	print("crosshair found: ", crosshair != null)
func _physics_process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		 # Debug:
		if hit.name == "lock":
			if  !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				player_ui.open_lock()
		
		elif hit.name == "note":
			if !crosshair.visible:
				crosshair.visible = true
			if !player_ui.tutorial_shown["interact_note"]:
				player_ui.show_tutorial_message("Press E to pick up and read the note or to interact", "interact_note", 4.0)
			if Input.is_action_just_pressed("interact"):
				if note_sound:
					note_sound.play()
				if player_ui.current_task_id == 1:
					player_ui.show_note()
					player_ui.advance_task(1, "Check the drawer in the bedroom for a clue")
				else:
					player_ui.show_note()
		elif hit.name == "note2":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
				
			if Input.is_action_just_pressed("interact"):
				if note_sound:
					note_sound.play()
					if player_ui.current_task_id == 2:
						player_ui.show_note2()
						player_ui.advance_task(2, "Search for the second clue")
					elif player_ui.current_task_id < 2:
						player_ui.locked_message()
						player_ui.set_task("Complete the current task first!")
				
		elif hit.name == "note3":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				if note_sound:
					note_sound.play()
					if player_ui.current_task_id == 3:
						player_ui.show_note3() 
						player_ui.advance_task(3, "Search for the third clue!")
					elif player_ui.current_task_id < 3:
						player_ui.locked_message()
						player_ui.set_task("This is locked. Complete previous tasks!")
		elif hit.name == "note4":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
				
			if Input.is_action_just_pressed("interact"):
				if note_sound:
					note_sound.play()
					if player_ui.current_task_id == 4:
						player_ui.show_note4()
						player_ui.advance_task(4, "Almost there, follow your gut")
					elif player_ui.current_task_id < 4:
						player_ui.locked_message()
						player_ui.set_task("This is locked. Complete previous tasks!")
		elif hit.name == "note5":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				if note_sound:
					note_sound.play()
					if player_ui.current_task_id == 5:
						player_ui.show_note5()
						player_ui.advance_task(5, "Use the passcode to unclock the door and escape")
					elif player_ui.current_task_id < 5:
						player_ui.locked_message()
						player_ui.set_task("This is locked. Complete previous tasks!")
					
		elif hit.is_in_group("oven"):
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().toggle_door()
		elif hit.name == "door":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				if door_s:
					door_s.play()
					hit.get_parent().get_parent().get_parent().toggle_door()
				
		elif hit.name == "drawer":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				if drawer_s:
					drawer_s.play()
				hit.get_parent().get_parent().toggle_door()
				if hit.is_in_group("firstd"):
					var drawer_parent = hit.get_parent().get_parent()
					var note_inside = drawer_parent.get_node_or_null("note2")  
					if note_inside != null:
						note_inside.visible = true
						print("Note2 is now visible in the drawer!")
					#player_ui.advance_task(2, "Great! You found the clue. Now go to the clue.")
		else: 
			if crosshair.visible:
				crosshair.visible = false
	else:
		if crosshair.visible:
			crosshair.visible = false
