tool
extends CanvasLayer

signal number_input

var number_intent = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font.size = 65
	$"Control/Label1Body/Label1".set("custom_fonts/font", dynamic_font)
	$"Control/Label2Body/Label2".set("custom_fonts/font", dynamic_font)
	$"Control/Label3Body/Label3".set("custom_fonts/font", dynamic_font)
	$"Control/Label4Body/Label4".set("custom_fonts/font", dynamic_font)
	$"Control/Label5Body/Label5".set("custom_fonts/font", dynamic_font)
	$"Control/Label6Body/Label6".set("custom_fonts/font", dynamic_font)
	$"Control/Label7Body/Label7".set("custom_fonts/font", dynamic_font)
	$"Control/Label8Body/Label8".set("custom_fonts/font", dynamic_font)
	$"Control/Label9Body/Label9".set("custom_fonts/font", dynamic_font)
	
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)

func _on_Label1Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",1)
			print("1")

func _on_Label2Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",2)
			print("2")

func _on_Label3Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",3)
			print("3")

func _on_Label4Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",4)
			print("4")

func _on_Label5Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",5)
			print("5")

func _on_Label6Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",6)
			print("6")

func _on_Label7Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",7)
			print("7")

func _on_Label8Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",8)
			print("8")

func _on_Label9Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			number_intent = true
		if event.button_index == BUTTON_LEFT and event.pressed == false:
			Events.emit_signal("number_input",9)
			print("9")

func _on_BlankSpace_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == false and number_intent == false:
			Events.emit_signal("hud_disengage")
			print("HUD disengage click")
		elif event.button_index == BUTTON_LEFT and event.pressed == false and number_intent == true:
			number_intent = false
