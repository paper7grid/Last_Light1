extends RayCast3D
@onready var player_ui = get_parent().get_parent().get_node("player_ui")
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
			if Input.is_action_just_pressed("interact"):
				print("Interact pressed on note!")  # Debug
				if player_ui.current_task_id == 1:
					player_ui.show_note()
					player_ui.advance_task(1, "Check the drawer in the bedroom for a clue")
				else:
					player_ui.show_note()
		elif hit.name == "note2":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
				
			if Input.is_action_just_pressed("interact"):
				player_ui.show_note2()  #  note_open2
				if player_ui.current_task_id == 2:
					player_ui.advance_task(2, "Search for the second clue")
				elif player_ui.current_task_id < 2:
					print("You need to complete the previous task first")
					player_ui.set_task("Complete the current task first!")
				
		elif hit.name == "note3":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				player_ui.show_note3()  #  note_open3
				if player_ui.current_task_id == 3:
					player_ui.advance_task(3, "Search for the third clue!")
				elif player_ui.current_task_id < 3:
					print("Locked - complete previous tasks")
					player_ui.set_task("This is locked. Complete previous tasks!")
		elif hit.name == "note4":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
				
			if Input.is_action_just_pressed("interact"):
				player_ui.show_note4()  #  note_open3
				if player_ui.current_task_id == 4:
					player_ui.advance_task(4, "Almost there, follow your gut")
				elif player_ui.current_task_id < 4:
					print("Locked - complete previous tasks")
					player_ui.show_note().visible = false
					player_ui.set_task("This is locked. Complete previous tasks!")

					
		elif hit.name == "note5":
			if crosshair != null and !crosshair.visible:
				crosshair.visible = true
				
			if Input.is_action_just_pressed("interact"):
				player_ui.show_note5()  #  note_open3
				if player_ui.current_task_id == 5:
					player_ui.advance_task(5, "Use the passcode to unclock the door and escape")
				elif player_ui.current_task_id < 5:
					print("Locked - complete previous tasks")
					player_ui.show_note().visible = false
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
				if hit.is_in_group("maindoor"):
					if player_ui.current_task_id >= 5:
						player_ui.open_lock()
					else:
						player_ui.set_task("The door is locked. Find a way to escape!")
				else: 
					hit.get_parent().get_parent().get_parent().toggle_door()
				
		elif hit.name == "drawer":
			if !crosshair.visible:
				crosshair.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().toggle_door()
				if hit.is_in_group("firstd"):
					var drawer_parent = hit.get_parent().get_parent()
					var note_inside = drawer_parent.get_node_or_null("note2")  # Changed from "note" to "note2"
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
			
			
