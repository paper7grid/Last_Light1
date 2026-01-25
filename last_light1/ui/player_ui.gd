extends Control
var current_task_id: int = 1  
#  when the node enters the scene tree for the first time.
func _ready() -> void:
	$pause_menu.visible = false
	$note_open.visible = false
	$taskui/tasktxt.text = "Pick up the paper and read it"
	print("Game Started. Current Task ID is: ", current_task_id)

func show_note_ui():
	if !$note_open.visible:
		$note_open.visible = true
		get_tree().paused = true 
	
func _on_close_note_pressed():
	$note_open.visible = false
	get_tree().paused = false
	Input.set_mouse_mode
	
func set_task(tasktxt: String):
	$taskui/tasktxt.text = tasktxt
	
func advance_task(id: int, next_task_text: String):
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

	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		$pause_menu.visible = !$pause_menu.visible
		get_tree().paused = $pause_menu.visible
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if !get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



	
	
