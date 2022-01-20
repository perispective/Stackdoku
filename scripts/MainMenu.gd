tool
extends CanvasLayer

var high_score_list
var new_high_score_move
var new_high_score_time
var new_high_score_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_win_stats",self,"_game_win_stats")
	high_score_list = {}
	high_score_list = _high_score_load()
	_update_score_menu()
	_set_fonts()

func _set_fonts():
	var dynamic_font_xs = DynamicFont.new()
	dynamic_font_xs.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font_xs.size = 25
	var dynamic_font_s = DynamicFont.new()
	dynamic_font_s.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font_s.size = 40
	var dynamic_font_l = DynamicFont.new()
	dynamic_font_l.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font_l.size = 55
	$"New Game Start/New Game Button".set("custom_fonts/font", dynamic_font_l)
	$"In-Game Menu/Game Timer".set("custom_fonts/font", dynamic_font_s)
	$"In-Game Menu/Game Moves".set("custom_fonts/font", dynamic_font_s)
	$"Win Screen/Moves Label".set("custom_fonts/font", dynamic_font_s)
	$"Win Screen/Time Label".set("custom_fonts/font", dynamic_font_s)
	$"Win Screen/Win Moves".set("custom_fonts/font", dynamic_font_s)
	$"Win Screen/Win Time".set("custom_fonts/font", dynamic_font_s)
	$"Win Screen/Win Title".set("custom_fonts/font", dynamic_font_l)
	$"Win Screen/New Game Button".set("custom_fonts/font", dynamic_font_s)
	$"Options Menu/High Score Button".set("custom_fonts/font", dynamic_font_s)
	$"Options Menu/Game Difficulty".set("custom_fonts/font", dynamic_font_s)
	$"Options Menu/Check Easy".set("custom_fonts/font", dynamic_font_xs)
	$"Options Menu/Check Normal".set("custom_fonts/font", dynamic_font_xs)
	$"Options Menu/Check Difficult".set("custom_fonts/font", dynamic_font_xs)
	$"Options Menu/Options Close Button".set("custom_fonts/font", dynamic_font_xs)
	$"High Score Menu/Moves Label".set("custom_fonts/font", dynamic_font_xs)
	$"High Score Menu/Time Label".set("custom_fonts/font", dynamic_font_xs)

func _game_win_stats(moves,time):
	new_high_score_move = moves + 1
	new_high_score_time = time
	print("New High Score to Review = " + str(new_high_score_move) + " " + str(("%-1.1f" % new_high_score_time) + "s"))
	_high_score_save()
#	$"Win Time".text = str("%-1.1f" % time) + "s"

func _high_score_load():
	var file = File.new()
	var err = file.open("user://high_score.dat", File.READ)
	if err != OK:
		file.open("user://high_score.dat",File.WRITE)
		for key in range(1,11):
			high_score_list[key] = "0,0.0"
			print(high_score_list[key])
		file.store_var(high_score_list)
	else:
		file.open("user://high_score.dat", File.READ)
	var content = file.get_var(true)
	file.close()
	return content

func _high_score_save():
	print("Save function called")
	new_high_score_pos = _check_high_scores()
	if (new_high_score_pos > 0): # if the new score is a high score
		_update_high_scores()
		var file = File.new()
		file.open("user://high_score.dat", File.WRITE)
		file.store_var(high_score_list)
		file.close()

func _check_high_scores():
	print("Check High Score function called")
	var new_high_score = 0
	for key in high_score_list.keys(): #iterate through the current high score list to see if the new score fits
		print ("Checking key " + str(key))
		var score_array = high_score_list[key].split(",",false)
		var moves = int(score_array[0])
		var time = float(score_array[1])
		print(str(moves) + " " + str(time))
		if (moves == 0):
			new_high_score = int(key)
			return new_high_score
		elif (new_high_score_move < moves):
			#identify the key that needs to be updated to save the new score
			new_high_score = int(key)
			return new_high_score
		elif (new_high_score_move == moves && new_high_score_time < time):
			#identify the key that needs to be updated to save the new score
			new_high_score = int(key)
			return new_high_score
	return new_high_score

func _update_high_scores():
	print("Update high scores function called")
	for pos in range(0,(10 - new_high_score_pos)):
		high_score_list[(10 - pos)] = high_score_list[(10 - pos - 1)]
		print(str(10 - pos) + " = " + high_score_list[10 - pos])
	high_score_list[new_high_score_pos] = str(new_high_score_move) + "," + str("%-1.1f" % new_high_score_time)
	print(str(new_high_score_pos) + " = " + high_score_list[new_high_score_pos])

func _on_Settings_Button_pressed():
	Events.emit_signal("toggle_options_menu")

func _on_Options_Close_Button_pressed():
	Events.emit_signal("toggle_options_menu")

func _on_Score_Close_Button_pressed():
	Events.emit_signal("toggle_high_score_menu")

func _on_High_Score_Button_pressed():
	Events.emit_signal("toggle_high_score_menu")

func _on_Main_Menu_Button_pressed():
	Events.emit_signal("clear_game_board")

func _on_New_Game_Button_pressed():
	Events.emit_signal("new_game_start")
	print("Start New Game")

func _update_score_menu():
	for pos in range(1,11):
		var moves_label = get_node("High Score Menu/Win Moves " + str(pos))
		var time_label = get_node("High Score Menu/Win Time " + str(pos))
		var moves_update = high_score_list[pos].split(",",false)[0]
		var time_update = high_score_list[pos].split(",",false)[1]
		moves_label.text = str(moves_update)
		time_label.text = str(time_update)
		

