extends Control

# Game menu variables
var time_elapsed := 0.0
var timer_active := false
var game_win_time := 0.0
var moves := 0
var game_win_moves := 0

# Set time elapsed and game moves to zero, establish Event connections
func _ready():
	time_elapsed = 0.0
	timer_active = false
	moves = 0
	Events.connect("new_game_start",self,"_on_new_game_start")
	Events.connect("game_won",self,"_on_game_won")
	Events.connect("number_input",self,"_on_number_input")

# Update the game timer for every 0.1 second
func _process(delta: float) -> void:
	if (timer_active):
		time_elapsed += delta
		$"Game Timer".text = str("%-1.1f" % time_elapsed) + "s"

# When a new game has started, make sure time and moves are set to zero
# Then enable the game timer
func _on_new_game_start():
	time_elapsed = 0.0
	timer_active = true
	moves = 0
	$"Game Moves".text = str(moves)

# Whenever the player inputs a value on a space, increase the number of moves
func _on_number_input(value):
	moves += 1
	$"Game Moves".text = str(moves)

# When the game is won, let the world know the number of moves and game time
func _on_game_won():
	timer_active = false
	game_win_time = time_elapsed
	game_win_moves = moves
	Events.emit_signal("game_win_stats",game_win_moves,game_win_time)
