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

func _on_New_Game_Button_pressed():
	Events.emit_signal("new_game_start")
	print("Start New Game")

func _game_win_stats(moves,time):
	new_high_score_move = moves + 1
	new_high_score_time = time
	_high_score_save()
#	$"Win Time".text = str("%-1.1f" % time) + "s"

func _high_score_load():
	var file = File.new()
	var err = file.open("user://high_score.dat", File.READ)
	if err != OK:
		file.open("user://high_score.dat",File.WRITE)
		for key in range(1,11):
			high_score_list[key] = "0,0.0"
		file.store_var(high_score_list)
	else:
		file.open("user://high_score.dat", File.READ)
	var content = file.get_var(true)
	file.close()
	return content

func _high_score_save():
	new_high_score_pos = _check_high_scores()
	if (new_high_score_pos > 0): # if the new score is a high score
		_update_high_scores()
		var file = File.new()
		file.open("user://high_score.dat", File.WRITE)
		file.store_var(high_score_list)
		file.close()

func _check_high_scores():
	var new_high_score = 0
	for key in high_score_list.keys(): #iterate through the current high score list to see if the new score fits
		var score_array = high_score_list[key].split(",",false)
		var moves = int(score_array[0])
		var time = float(score_array[1])
		if (new_high_score_move < moves):
			#identify the key that needs to be updated to save the new score
			new_high_score = int(key)
			return new_high_score
		elif (new_high_score_move == moves && new_high_score_time < time):
			#identify the key that needs to be updated to save the new score
			new_high_score = int(key)
			return new_high_score
	return new_high_score

func _update_high_scores():
	yield() #iterate through the high score list to overwrite everything after new_high_score_pos

#	var name_array = self.name.split(",",false)
#	var row = int(name_array[1])
#	var col = int(name_array[2])
