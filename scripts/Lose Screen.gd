extends Control

# Event connections
func _ready():
	pass

func _on_New_Game_Button_pressed_lose():
	Events.emit_signal("new_game_start")
