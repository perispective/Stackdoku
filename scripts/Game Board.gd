extends Spatial

# Board state variables
var pressed := false
var some_space_is_selected := false
var spaces_won
var spaces_used
var music_enabled := true
var difficulty

# Sudoku game logic variables
var sudoku
const block_size = 3
const num_rows = 9
const num_cols = 9
const num_to_win = num_rows * num_cols #potentially extensible to larger boards
var domains #dictionary, key = space ID and value = space value

# Event connections > establish blank domains + spaces won dictionaries > clear board
func _ready():
	Events.connect("space_has_been_clicked_on",self,"_on_space_selected")
	Events.connect("space_has_been_clicked_off",self,"_on_space_deselected")
	Events.connect("adjust_space_size",self,"_on_space_size_update")
	Events.connect("hud_disengage",self,"_on_hud_disengage")
	Events.connect("new_game_start",self,"_on_new_game_start")
	Events.connect("space_win_state",self,"_on_space_win_state")
	Events.connect("toggle_info_menu",self,"_on_toggle_info_menu")
	Events.connect("toggle_options_menu",self,"_on_toggle_options_menu")
	Events.connect("toggle_high_score_menu",self,"_on_toggle_high_score_menu")
	Events.connect("toggle_credits_menu",self,"_on_toggle_credits_menu")
	Events.connect("toggle_sound",self,"_on_toggle_sound")
	Events.connect("clear_game_board",self,"_on_clear_game_board")
	Events.connect("button_press",self,"_on_button_press")
	Events.connect("set_difficulty",self,"_on_set_difficulty")
	domains = {}
	spaces_won = {}
	spaces_used = {}
	_on_clear_game_board()

# Translate mouse input on the game board screen into rotation of the game board
func _input(event: InputEvent) -> void:
	if pressed and event is InputEventMouseMotion and some_space_is_selected == false:
		$"Game Plane".rotation.y += event.relative.x*0.005
	elif event is InputEventScreenDrag and some_space_is_selected == false:
		$"Game Plane".rotation.y += event.relative.x*0.005

# Physics check for mouse button pressed
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		pressed = true
	if Input.is_action_just_released("click"):
		pressed = false

# While only the main menu screen is visible, auto-rotate the game board (pretty...)
func _process(delta):
	if $MainMenu.get_child(0).visible:
		$"Game Plane".rotation.y += 0.005

# When a space is selected with mouse/touch, announce to the world and show the hud
func _on_space_selected(space_name: String) -> void:
	Events.emit_signal("hud_value_reset")
	if difficulty == 1:
		check_values(space_name)
	$"InputHUD".get_child(0).show()
	some_space_is_selected = true
	Events.emit_signal("board_space_is_selected",true)
	Events.emit_signal("button_press","HUD")

# When a space is deselected by click, announce to the world and hide the hud
func _on_space_deselected() -> void:
	$"InputHUD".get_child(0).hide()
	some_space_is_selected = false
	Events.emit_signal("board_space_is_selected",false)

# When the hud is disengaged (click-off or ESC), hide the hud
func _on_hud_disengage() -> void:
	$"InputHUD".get_child(0).hide()
	some_space_is_selected = false

# On Easy mode, if the selected space is in a row, col, or block 
# with an already used number, disable it in the HUD
func check_values(space_name: String):
	var check_array = [1,2,3,4,5,6,7,8,9]
	var disable_array = []
	var space_row = int(space_name.split(",")[1])
	var space_col = int(space_name.split(",")[2])
	for num in check_array:
		if not check_if_safe(space_row,space_col,num):
			disable_array.append(num)
	Events.emit_signal("hud_value_disable",disable_array)

#Checks whether a particular value is already used in this 3x3 box
func unused_in_box(row,col,num):
	for r in [0,1,2]:
		for c in [0,1,2]:
			if spaces_used.has("Space," + str(row + r) + "," + str(col + c)):
				if spaces_used["Space," + str(row + r) + "," + str(col + c)] == num:
					return false
	return true

#Checks whether a particular value is already used in this row?
func unused_in_row(row,num):
	for c in range(1,10):
		if spaces_used.has("Space," + str(row) + "," + str(c)):
			if spaces_used["Space," + str(row) + "," + str(c)] == num:
				return false
	return true

#Checks whether a particular value is already used in this column
func unused_in_col(col,num):
	for r in range(1,10):
		if spaces_used.has("Space," + str(r) + "," + str(col)):
			if spaces_used["Space," + str(r) + "," + str(col)] == num:
				return false
	return true

#Checks against all three validity rules: row, col, and box
func check_if_safe(row,col,num):
	return (unused_in_box(row-((row-1)%block_size),col-((col-1)%block_size),num) && unused_in_col(col,num) && unused_in_row(row,num))


# When a number is input for a space, update the size
# If the size is set to 0 or less, change size to allow visibility of label
func _on_space_size_update(space_name,size) -> void:
	get_node("Game Plane/" + space_name).scale = Vector3(1,size,1)
	if size < 1:
		get_node("Game Plane/" + space_name + "/Label Sprite").translation = Vector3(0,0 - .01,0)
	else:
		get_node("Game Plane/" + space_name + "/Label Sprite").translation = Vector3(0,2.01,0)

# When a new game is started, instantiate the Sudoku class for a new game board
# Then load the grid, reset the game plane rotation, erase the spaces won dictionary
# Finally, reset the menus node so only the active game menu is visible + play music
func _on_new_game_start() -> void:
	sudoku = Sudoku.new()
	load_grid()
	$"Game Plane".rotation.y = 0
	for key in spaces_won.keys():
		spaces_won.erase(key)
	for key in spaces_used.keys():
		spaces_used.erase(key)
	$MainMenu.get_child(0).hide()
	$MainMenu.get_child(1).show()
	$MainMenu.get_child(2).hide()
	$MainMenu.get_child(3).hide()
	$MainMenu.get_child(4).hide()
	$MainMenu.get_child(5).hide()
	$MainMenu.get_child(6).hide()
	if music_enabled:
		$Music.play()

# Pull the new game board values from the sudoku class and add to the local dictionary
func load_grid():
	domains = sudoku.get_grid()
	for key in domains.keys():
		Events.emit_signal("number_assign", "Space," + key, domains[key])

# When a new space value is a 'win', add it to the spaces won dictionary
# If the number of spaces won is equal to the win state, announce the game is won
func _on_space_win_state(space_name, valid, num, first):
	if (valid and not first):
		spaces_won[space_name] = valid
		spaces_used[space_name] = num
	else:
		spaces_won.erase(space_name)
		spaces_used[space_name] = num
	if spaces_won.size() == num_to_win:
		Events.emit_signal("game_won")
		$MainMenu.get_child(3).show()

# Turns the options menu on and off (returns to the main menu)
func _on_toggle_options_menu():
	if($MainMenu.get_child(2).visible):
		$MainMenu.get_child(2).hide()
		$MainMenu.get_child(0).show()
	else:
		$MainMenu.get_child(2).show()
		$MainMenu.get_child(0).hide()

# Turns the high score menu on and off (returns to the options menu)
func _on_toggle_high_score_menu():
	if($MainMenu.get_child(4).visible):
		$MainMenu.get_child(4).hide()
		$MainMenu.get_child(2).show()
	else:
		$MainMenu.get_child(4).show()
		$MainMenu.get_child(2).hide()

# Turns the info menu on and off (returns to the main menu)
func _on_toggle_info_menu():
	if($MainMenu.get_child(5).visible):
		$MainMenu.get_child(5).hide()
		$MainMenu.get_child(0).show()
	else:
		$MainMenu.get_child(5).show()
		$MainMenu.get_child(0).hide()

# Turns the credits menu on and off (returns to the options menu)
func _on_toggle_credits_menu():
	if($MainMenu.get_child(6).visible):
		$MainMenu.get_child(6).hide()
		$MainMenu.get_child(2).show()
	else:
		$MainMenu.get_child(6).show()
		$MainMenu.get_child(2).hide()

# Toggles the sound setting on and off
func _on_toggle_sound(sound_on: bool):
	if sound_on:
		music_enabled = true
	else:
		music_enabled = false

# Sound effects when buttons are pressed in the UI
func _on_button_press(type):
	if music_enabled:
		if type == "UI":
			$"Click (Treble)".play()
		elif type == "HUD":
			$"Click (Bass)".play()
		elif type == "space":
			$"Ping SFX".play()

# Clears the game board, changes the menu node to the main menu
# Then clears out the game board dictionary and stops the game music
func _on_clear_game_board():
	$"InputHUD".get_child(0).hide()
	$MainMenu.get_child(0).show()
	$MainMenu.get_child(1).hide()
	$MainMenu.get_child(2).hide()
	$MainMenu.get_child(3).hide()
	$MainMenu.get_child(4).hide()
	$MainMenu.get_child(5).hide()
	$MainMenu.get_child(6).hide()
	if (domains.size() > 0):
		for key in domains.keys():
			domains[key] = 0
			Events.emit_signal("number_assign", "Space," + key, domains[key])
	if music_enabled:
		$Music.stop()

func _on_set_difficulty(value):
	difficulty = value
