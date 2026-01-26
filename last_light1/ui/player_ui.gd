extends Control

var current_task_id: int = 1  
var time_remaining: float = 900.0  # 15 minutes about? 
var game_over: bool = false
var correct_passcode: String = "7542"
var entered_passcode: String = ""

func _ready() -> void:
	print("player_ui ready!")
	$pause_menu.visible = false
	$wrong.visible = false
	$note_open.visible = false
	$win_screen.visible = false
	$game_over_screen.visible = false
	$note_open2.visible = false 
	$note_open3.visible = false
	$note_open4.visible = false
	$note_open5.visible = false
	$lock_ui.visible = false
	$taskui/tasktxt.text = "Find and read the mysterious paper"
	print("Current Task ID: ", current_task_id)
	update_timer_display()
	

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
func show_note3():
	if !$note_open3.visible:
		$note_open3.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func show_note4():
	if !$note_open4.visible:
		$note_open4.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func show_note5():
	if !$note_open5.visible:
		$note_open5.visible = true
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
	
func _on_close_note3_pressed():
	$note_open3.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _on_close_note4_pressed():
	$note_open4.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _on_close_note5_pressed():
	$note_open5.visible = false
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
		
func update_timer_display():
	var minutes = int(time_remaining) / 60
	var seconds = int(time_remaining) % 60
	# Update 
	if $taskui.has_node("timer"):
		$taskui.get_node("timer").text = "%02d:%02d" % [minutes, seconds]
		
func open_lock():
	$lock_ui.visible = true
	get_tree().paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func exit_lock():
	$lock_ui.visible = false
	$wrong.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func game_over_lose():
	game_over = true
	get_tree().paused = true
	if has_node("game_over_screen"):
		$game_over_screen.visible = true
	set_task("TIME'S UP! The killer found you...")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func game_over_win():
	game_over = true
	get_tree().paused = true
	if has_node("win_screen"):
		$win_screen.visible = true
	set_task("YAY")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume_game():
	get_tree().paused = false
	$pause_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func quit_game():
	get_tree().quit()
	
func play_again():
	get_tree().reload_current_scene()
	
func show_passcode_entry():
	if has_node("lock_ui"):
		$lock_ui.visible = true
		$lock_ui/passcode_input.text = ""
		entered_passcode = ""
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func check_passcode():
	entered_passcode = $lock_ui/passcode_input.text
	if entered_passcode == correct_passcode:
		print("Correct passcode!")
		$lock_ui.visible = false
		
		game_over_win()
	else: 
			print("Wrong passcode!")
			$wrong.visible = true
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	# Timer countdown
	if !game_over and !get_tree().paused:
		time_remaining -= delta
		update_timer_display()
		if time_remaining <= 0:
			game_over_lose()
	if Input.is_action_just_pressed("pause") and !$note_open.visible:
		$pause_menu.visible = !$pause_menu.visible
		get_tree().paused = $pause_menu.visible
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if !get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
