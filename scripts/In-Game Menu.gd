extends Control

var time_elapsed := 0.0
var timer_active := false
var game_win_time := 0.0
var moves := 0
var game_win_moves := 0

func _ready():
	time_elapsed = 0.0
	timer_active = false
	moves = 0
	Events.connect("new_game_start",self,"_on_new_game_start")
	Events.connect("game_won",self,"_on_game_won")
	Events.connect("number_input",self,"_on_number_input")

func _process(delta: float) -> void:
	if (timer_active):
		time_elapsed += delta
		$"Game Timer".text = str("%-1.1f" % time_elapsed) + "s"

func _on_new_game_start():
	time_elapsed = 0.0
	timer_active = true
	moves = 0
	$"Game Moves".text = str(moves)

func _on_number_input(value):
	moves += 1
	$"Game Moves".text = str(moves)

func _on_game_won():
	timer_active = false
	game_win_time = time_elapsed
	game_win_moves = moves
	Events.emit_signal("game_win_stats",game_win_moves,game_win_time)
