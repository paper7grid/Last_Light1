extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_node("bg_music"):
		$bg_music.play()
