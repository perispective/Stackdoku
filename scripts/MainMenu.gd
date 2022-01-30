tool
extends CanvasLayer

# Main menu game variables
var high_score_list
var new_high_score_move
var new_high_score_time
var new_high_score_pos

# Establishes connection to game win event, sets menu fonts, and loads high scores
func _ready():
	# warning-ignore:return_value_discarded
	Events.connect("game_win_stats",self,"_game_win_stats")
	high_score_list = {}
	high_score_list = _high_score_load()
	_set_fonts()

#Sets up fonts for all the labels... I'm sure there's a less gross way to do this
func _set_fonts():
	var dynamic_font_xs = DynamicFont.new() # Extra Small Font
	dynamic_font_xs.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font_xs.size = 25
	var dynamic_font_s = DynamicFont.new() # Small Font
	dynamic_font_s.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font_s.size = 40
	var dynamic_font_l = DynamicFont.new() # Large Font
	dynamic_font_l.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font_l.size = 55
	$"New Game Start/New Game Button".set("custom_fonts/font", dynamic_font_l)
	$"In-Game Menu/Game Timer".set("custom_fonts/font", dynamic_font_s)
	$"In-Game Menu/Game Moves".set("custom_fonts/font", dynamic_font_s)
	$"In-Game Menu/Quit Game Button".set("custom_fonts/font", dynamic_font_s)
	$"In-Game Menu/Camera Label".set("custom_fonts/font", dynamic_font_xs)
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
	$"Info Menu/Info Label 1".set("custom_fonts/font", dynamic_font_xs)
	$"Credits Menu/Credits Label".set("custom_fonts/font", dynamic_font_xs)

# When the game is won, pass it along to the high score save function
func _game_win_stats(moves,time):
	new_high_score_move = moves + 1
	new_high_score_time = time
	_high_score_save()

# Loads high scores from local file storage into the game menu node
func _high_score_load():
	var file = File.new()
	var err = file.open("user://high_score.dat", File.READ)
	if err != OK:
		file.open("user://high_score.dat",File.WRITE)
		for key in range(1,11):
			high_score_list[key] = "0,0.0"
		file.store_var(high_score_list)
	file.open("user://high_score.dat", File.READ)
	var content = file.get_var(true)
	file.close()
	return content

# Goes into the high score dictionary; if the new score belongs in the Top 10, add it
func _high_score_save():
	new_high_score_pos = _check_high_scores()
	if (new_high_score_pos > 0): # if the new score is a high score
		_update_high_scores()
		var file = File.new()
		file.open("user://high_score.dat", File.WRITE)
		file.store_var(high_score_list)
		file.close()

# Run through the high score list, check to see if the new score beats any prior scores
func _check_high_scores():
	var new_high_score = 0
	for key in high_score_list.keys(): #iterate through the current high score list to see if the new score fits
		var score_array = high_score_list[key].split(",",false)
		var moves = int(score_array[0])
		var time = float(score_array[1])
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

# Update the high scores list based on the new high score value
func _update_high_scores():
	for pos in range(0,(10 - new_high_score_pos)):
		high_score_list[(10 - pos)] = high_score_list[(10 - pos - 1)]
	high_score_list[new_high_score_pos] = str(new_high_score_move) + "," + str("%-1.1f" % new_high_score_time)

# Update the high score menu based on the current high score list dictionary
func _update_score_menu():
	for pos in range(1,11):
		var moves_label = get_node("High Score Menu/Win Moves " + str(pos))
		var time_label = get_node("High Score Menu/Win Time " + str(pos))
		var moves_update = high_score_list[pos].split(",",false)[0]
		var time_update = high_score_list[pos].split(",",false)[1]
		moves_label.text = str(moves_update)
		time_label.text = str(time_update)

func _on_Settings_Button_pressed():
	Events.emit_signal("toggle_options_menu")
	Events.emit_signal("button_press","UI")
	_update_score_menu()

func _on_Options_Close_Button_pressed():
	Events.emit_signal("toggle_options_menu")
	Events.emit_signal("button_press","UI")

func _on_Score_Close_Button_pressed():
	Events.emit_signal("toggle_high_score_menu")
	Events.emit_signal("button_press","UI")

func _on_High_Score_Button_pressed():
	Events.emit_signal("toggle_high_score_menu")
	Events.emit_signal("button_press","UI")

func _on_Main_Menu_Button_pressed():
	Events.emit_signal("clear_game_board")
	Events.emit_signal("button_press","UI")
	$"In-Game Menu/Camera Button".pressed = false

func _on_New_Game_Button_pressed():
	Events.emit_signal("new_game_start")
	Events.emit_signal("button_press","UI")

func _on_Quit_Game_Button_pressed():
	Events.emit_signal("clear_game_board")
	Events.emit_signal("button_press","UI")
	$"In-Game Menu/Camera Button".pressed = false

func _on_Info_Button_pressed():
	Events.emit_signal("toggle_info_menu")
	Events.emit_signal("button_press","UI")

func _on_Info_Close_Button_pressed():
	Events.emit_signal("toggle_info_menu")
	Events.emit_signal("button_press","UI")

func _on_Credits_Button_pressed():
	Events.emit_signal("toggle_credits_menu")
	Events.emit_signal("button_press","UI")

func _on_Credits_Close_Button_pressed():
	Events.emit_signal("toggle_credits_menu")
	Events.emit_signal("button_press","UI")

# When the sound button is toggled, tell the world if sound should now be on or off
func _on_Sound_Button_toggled(button_pressed):
	if button_pressed: #button_pressed = true means sound should be changed to muted
		Events.emit_signal("toggle_sound",false)
		$"Options Menu/Game Sound".text = "Sound Off"
	else:
		Events.emit_signal("toggle_sound",true)
		Events.emit_signal("button_press","UI")
		$"Options Menu/Game Sound".text = "Sound On"

# When the sound button label is pressed, toggle the sound button
func _on_Game_Sound_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == false:
		if $"Options Menu/Sound Button".pressed == true: #true means sound is already muted
			Events.emit_signal("button_press","UI")
			$"Options Menu/Sound Button".pressed = false
		else:
			$"Options Menu/Sound Button".pressed = true

# Adjusts the difficulty depending on which difficulty check is in the toggled state
func _on_Check_Easy_toggled(button_pressed):
	Events.emit_signal("set_difficulty",1)

func _on_Check_Normal_toggled(button_pressed):
	Events.emit_signal("set_difficulty",2)

func _on_Check_Difficult_toggled(button_pressed):
	Events.emit_signal("set_difficulty",3)

# Adjusts the camera between Angled (1) and Bird's Eye (2) views when the button is toggled
func _on_Camera_Button_toggled(button_pressed):
	if button_pressed == true: # Pressed = Top Down
		Events.emit_signal("toggle_camera",2)
		$"In-Game Menu/Camera Label".text = "Top-Down"
	else: # !Pressed = Angled (Default)
		Events.emit_signal("toggle_camera",1)
		$"In-Game Menu/Camera Label".text = "Angle"
	
