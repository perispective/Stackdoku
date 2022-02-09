tool
extends CanvasLayer

signal number_input

var number_intent = false

var disabled

var button_press_color = Color(.6,.6,.6)

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("hud_value_disable",self,"_on_hud_value_disable")
	Events.connect("hud_value_reset",self,"_on_hud_value_reset")
	button_press_color.s -= 0.9
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font.size = 65
	disabled = {}
	for num in range(1,10):
		disabled[num] = false
	$"Control/Label1Body/Label1".set("custom_fonts/font", dynamic_font)
	$"Control/Label2Body/Label2".set("custom_fonts/font", dynamic_font)
	$"Control/Label3Body/Label3".set("custom_fonts/font", dynamic_font)
	$"Control/Label4Body/Label4".set("custom_fonts/font", dynamic_font)
	$"Control/Label5Body/Label5".set("custom_fonts/font", dynamic_font)
	$"Control/Label6Body/Label6".set("custom_fonts/font", dynamic_font)
	$"Control/Label7Body/Label7".set("custom_fonts/font", dynamic_font)
	$"Control/Label8Body/Label8".set("custom_fonts/font", dynamic_font)
	$"Control/Label9Body/Label9".set("custom_fonts/font", dynamic_font)

# When the HUD is active, number key presses count as moves for numbers 1-9
# and ESC key will disengage the HUD
func _input(event):
	if event is InputEventKey and event.pressed and self.get_child(0).visible:
		if event.scancode == KEY_1 and not disabled[1]:
			Events.emit_signal("number_input",1)
		if event.scancode == KEY_2 and not disabled[2]:
			Events.emit_signal("number_input",2)
		if event.scancode == KEY_3 and not disabled[3]:
			Events.emit_signal("number_input",3)
		if event.scancode == KEY_4 and not disabled[4]:
			Events.emit_signal("number_input",4)
		if event.scancode == KEY_5 and not disabled[5]:
			Events.emit_signal("number_input",5)
		if event.scancode == KEY_6 and not disabled[6]:
			Events.emit_signal("number_input",6)
		if event.scancode == KEY_7 and not disabled[7]:
			Events.emit_signal("number_input",7)
		if event.scancode == KEY_8 and not disabled[8]:
			Events.emit_signal("number_input",8)
		if event.scancode == KEY_9 and not disabled[9]:
			Events.emit_signal("number_input",9)
		if event.scancode == KEY_ESCAPE:
			Events.emit_signal("hud_disengage")

# When the 1 button is pressed, announce the number input
func _on_Label1Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label1Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",1)
			_on_mouse_up()

# When the 2 button is pressed, announce the number input
func _on_Label2Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label2Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",2)
			_on_mouse_up()

# When the 3 button is pressed, announce the number input
func _on_Label3Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label3Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",3)
			_on_mouse_up()

# When the 4 button is pressed, announce the number input
func _on_Label4Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label4Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",4)
			_on_mouse_up()

# When the 5 button is pressed, announce the number input
func _on_Label5Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label5Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",5)
			_on_mouse_up()

# When the 6 button is pressed, announce the number input
func _on_Label6Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label6Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",6)
			_on_mouse_up()

# When the 7 button is pressed, announce the number input
func _on_Label7Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label7Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",7)
			_on_mouse_up()

# When the 8 button is pressed, announce the number input
func _on_Label8Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label8Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",8)
			_on_mouse_up()

# When the 9 button is pressed, announce the number input
func _on_Label9Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
			$Control/Label9Body/LabelSprite.modulate = button_press_color
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",9)
			_on_mouse_up()

# When HUD is engaged and non-button space is pressed, disengage the HUD
func _on_BlankSpace_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == false and number_intent == false:
			Events.emit_signal("hud_disengage")
		elif event.button_index == BUTTON_LEFT and event.pressed == false and number_intent == true:
			number_intent = false
			_on_mouse_up()

# For Easy mode, make it so the HUD knows which numbers to display (which correct values have not been used in the same row, column, or block of spaces)
func _on_hud_value_disable(disable_array):
	for num in disable_array:
		get_node("Control/Label" + str(num) + "Body").input_pickable = false
		get_node("Control/Label" + str(num) + "Body").visible = false
		disabled[num] = true

# Reset for disabled HUD inputs to avoid conflicts on new games and difficulty changes between rounds
func _on_hud_value_reset():
	for num in range(1,10):
		get_node("Control/Label" + str(num) + "Body").input_pickable = true
		get_node("Control/Label" + str(num) + "Body").visible = true
		disabled[num] = false

# Resets the visible state of all buttons in the HUD
func _on_mouse_up():
	pass
	$Control/Label1Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label2Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label3Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label4Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label5Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label6Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label7Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label8Body/LabelSprite.modulate = Color(1,1,1)
	$Control/Label9Body/LabelSprite.modulate = Color(1,1,1)
