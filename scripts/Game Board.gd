extends Spatial

# Board state variables
var pressed := false
var some_space_is_selected := false
var spaces_won

# Sudoku game logic variables
var sudoku
const num_rows = 9
const num_cols = 9
#const num_to_win = num_rows * num_cols
const num_to_win = 5
var domains

func _ready():
	$"InputHUD".get_child(0).hide()
	$MainMenu.get_child(1).hide()
	$MainMenu.get_child(2).hide()
	$MainMenu.get_child(3).hide()
	$MainMenu.get_child(4).hide()
	print($MainMenu.get_child(0).visible)
	print($MainMenu.get_child(1).visible)
	Events.connect("space_has_been_clicked_on",self,"_on_space_selected")
	Events.connect("space_has_been_clicked_off",self,"_on_space_deselected")
	Events.connect("adjust_space_size",self,"_on_space_size_update")
	Events.connect("hud_disengage",self,"_on_hud_disengage")
	Events.connect("new_game_start",self,"_on_new_game_start")
	Events.connect("space_win_state",self,"_on_space_win_state")
	Events.connect("toggle_options_menu",self,"_on_toggle_options_menu")
	Events.connect("toggle_high_score_menu",self,"_on_toggle_high_score_menu")
	domains = {}
	spaces_won = {}

func _input(event: InputEvent) -> void:
	if pressed and event is InputEventMouseMotion and some_space_is_selected == false:
		$"Game Plane".rotation.y += event.relative.x*0.005

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		pressed = true
	if Input.is_action_just_released("click"):
		pressed = false

func _on_space_selected(space_name: String) -> void:
	$"InputHUD".get_child(0).show()
	some_space_is_selected = true
	Events.emit_signal("board_space_is_selected",true)
	print("selection signal check for space " + space_name)
	
func _on_space_deselected() -> void:
	$"InputHUD".get_child(0).hide()
	some_space_is_selected = false
	Events.emit_signal("board_space_is_selected",false)
	print("deselection signal check")

func _on_hud_disengage() -> void:
	$"InputHUD".get_child(0).hide()
	some_space_is_selected = false
	print("board acks hud disengage")

func _on_space_size_update(space_name,size) -> void:
	get_node("Game Plane/" + space_name).scale = Vector3(1,size,1)
	if size < 1:
		get_node("Game Plane/" + space_name + "/Label Sprite").translation = Vector3(0,0 - .01,0)
		print("label translation: " + str(0 - .01))
	else:
		get_node("Game Plane/" + space_name + "/Label Sprite").translation = Vector3(0,2.01,0)

func _on_new_game_start() -> void:
	sudoku = Sudoku.new()
	load_grid()
	for key in spaces_won.keys():
		spaces_won.erase(key)
	$MainMenu.get_child(0).hide()
	$MainMenu.get_child(1).show()
	$MainMenu.get_child(2).hide()
	$MainMenu.get_child(3).hide()
	$MainMenu.get_child(4).hide()

func load_grid():
	domains = sudoku.get_grid()
	for key in domains.keys():
		print(key)
		Events.emit_signal("number_assign", "Space," + key, domains[key])
		print(key + " " + str(domains[key]))

func _on_space_win_state(space_name, valid):
	if (valid):
		spaces_won[space_name] = valid
		print("Win - " + str(spaces_won.size()))
	else:
		spaces_won.erase(space_name)
		print("Loss - " + str(spaces_won.size()))
	if spaces_won.size() == num_to_win:
		Events.emit_signal("game_won")
		$MainMenu.get_child(3).show()

func _on_toggle_options_menu():
	if($MainMenu.get_child(2).visible):
		$MainMenu.get_child(2).hide()
		$MainMenu.get_child(0).show()
	else:
		$MainMenu.get_child(2).show()
		$MainMenu.get_child(0).hide()

func _on_toggle_high_score_menu():
	if($MainMenu.get_child(4).visible):
		$MainMenu.get_child(4).hide()
		$MainMenu.get_child(2).show()
	else:
		$MainMenu.get_child(4).show()
		$MainMenu.get_child(2).hide()
