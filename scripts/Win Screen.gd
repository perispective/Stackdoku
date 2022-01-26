extends Control

var win_moves := 0
var win_time := 0.0

# Event connections
func _ready():
	Events.connect("game_win_stats",self,"_game_win_stats")
	Events.connect("new_game_start",self,"_on_new_game_start")

# When the game is won, display win moves and time
func _game_win_stats(moves,time):
	win_moves = moves + 1
	win_time = time
	$"Win Moves".text = str(win_moves)
	$"Win Time".text = str("%-1.1f" % win_time) + "s"

# When the win screen's new game button is pressed, announce to the world
func _on_New_Game_Button_pressed_win():
	Events.emit_signal("new_game_start")

# When a new game begins, zero out the win moves and time
func _on_new_game_start():
	win_time = 0.0
	win_moves = 0
	$"Win Moves".text = str(win_moves)
	$"Win Time".text = str("%-1.1f" % win_time) + "s"
