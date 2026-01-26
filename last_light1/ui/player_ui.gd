extends Control

var current_task_id: int = 1  

func _ready() -> void:
	print("player_ui ready!")
	$pause_menu.visible = false
	$note_open.visible = false
	$note_open2.visible = false 
	$taskui/tasktxt.text = "Find and read the mysterious paper"
	print("Current Task ID: ", current_task_id)

func show_note():
	print("show_note() called!")  # Debug
	if !$note_open.visible:
		$note_open.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		print("Note is now visible")  # Debug
		
func show_note2():
	if !$note_open2.visible:
		$note_open2.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_close_note_pressed():
	print("Closing note")  # Debug
	$note_open.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _on_close_note2_pressed():
	print("Closing note 2")
	$note_open2.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func set_task(tasktxt: String):
	$taskui/tasktxt.text = tasktxt
	print("Task set to: ", tasktxt)  # Debug
	
func advance_task(id: int, next_task_text: String):
	print("advance_task called with id: ", id, " current_task_id: ", current_task_id)  # Debug
	if id == current_task_id:
		set_task(next_task_text)
		current_task_id += 1
		print("Task Advanced to: ", current_task_id)

func resume_game():
	get_tree().paused = false
	$pause_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func quit_game():
	get_tree().quit()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and !$note_open.visible:
		$pause_menu.visible = !$pause_menu.visible
		get_tree().paused = $pause_menu.visible
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if !get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
