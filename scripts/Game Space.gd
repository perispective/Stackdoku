extends Spatial

#did the user click down on this space, indicating intent to select
var select_intent = false

#is this space presently in a selected state, yes or no
var space_is_selected = false

#is this space able to be selected right now, yes or no
var space_is_selectable = true

#what is the numeric value of this space
var space_value = 0

#what is the numeric input for this space
var space_input = 0

#signal for select_space and deselect_space functions
signal select_completed
signal deselect_completed

#material variables
var base_material 
var base_shadow 
var select_material 

#ready function for each game space
func _ready():
	Events.connect("board_space_is_selected",self,"_on_board_space_selected")
	Events.connect("hud_disengage",self,"_on_hud_disengage")
	Events.connect("number_input",self,"_on_number_input")
	Events.connect("number_assign",self,"_on_number_assign")
	Events.emit_signal("adjust_space_size",self.name,space_value - space_input + 1)
	if space_input == 0:
		$"Label Sprite/Label Viewport/Game Space Label".text = ""
	else:
		$"Label Sprite/Label Viewport/Game Space Label".text = str(space_input)
	base_material = SpatialMaterial.new()
	base_shadow = SpatialMaterial.new()
	select_material = SpatialMaterial.new()
	select_material.albedo_color = Color(0.92,0.69,0.13,1.0)
	determine_space_color()

#check for when the area for this game space has been selected
func _on_Game_Space_Area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true and space_is_selectable == true:
			if space_is_selected == false:
				select_intent = true
				print("select intent set for space " + self.name)
			else:
				select_intent = true
				print("deselect intent set for space " + self.name)
		elif event.button_index == BUTTON_LEFT and event.pressed == false and space_is_selectable == true:
			if select_intent == true:
				if space_is_selected == false:
					select_space()
					Events.emit_signal("space_has_been_clicked_on",self.name) #notify the world it's been clicked on
					print(self.name + " has been selected")
				else:
					deselect_space()
					Events.emit_signal("space_has_been_clicked_off") #otherwise, notify the world it's been clicked off
					print(self.name + " has been deselected")
		else:
			select_intent = false

func test(camera,event,position,normal,shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == false and space_is_selectable == true: #when a space is clicked and it's selectable
			if space_is_selected == false: #if this space isn't currently selected...
				select_space()
				Events.emit_signal("space_has_been_clicked_on",self.name) #notify the world it's been clicked on
				print(self.name + " has been selected")
			else:
				deselect_space()
				Events.emit_signal("space_has_been_clicked_off") #otherwise, notify the world it's been clicked off
				print(self.name + " has been deselected")

#state change for this space when it's been selected
func select_space():
	space_is_selected = true #change the state of selection, then...
	$"Game Space Cube".material_override = select_material #update the material to a selected state
	print(self.name + " selected")
	select_intent = false
	yield()

#state change for this space when it's been deselected
func deselect_space():
	space_is_selected = false #change the state of selection, then...
	$"Game Space Cube".material_override = base_material #return the material to its default state
	select_intent = false
	yield()
	
func enable_space():
	space_is_selectable = true
	select_intent = false
	yield()

func disable_space():
	space_is_selectable = false
	select_intent = false
	yield()

#Uses the box number of the grid to determine the base color for the space
func determine_space_color():
	var name_array = self.name.split(",",false)
	var row = int(name_array[1])
	var col = int(name_array[2])
	var box = (row-((row-1)%3)) + (col-((col-1)%3))
	if (box % 2) == 0:
		base_material.albedo_color = Color (0.85,0.85,0.85,1.0)
		base_material.params_diffuse_mode = base_material.DIFFUSE_TOON
		base_shadow.albedo_color = Color(0,0,0,1.0)
		base_shadow.params_grow = true
		base_shadow.params_grow_amount = 0.08
		base_shadow.params_diffuse_mode = base_shadow.DIFFUSE_TOON
		base_shadow.params_cull_mode = base_shadow.CULL_FRONT
		base_material.next_pass = base_shadow
		base_material.params_cull_mode = base_material.CULL_BACK
	else:
		base_material.albedo_color = Color (1.0,1.0,1.0,1.0)
		base_material.params_diffuse_mode = base_material.DIFFUSE_TOON
		base_shadow.albedo_color = Color(0,0,0,1.0)
		base_shadow.params_grow = true
		base_shadow.params_grow_amount = 0.08
		base_shadow.params_diffuse_mode = base_shadow.DIFFUSE_TOON
		base_shadow.params_cull_mode = base_shadow.CULL_FRONT
		base_material.next_pass = base_shadow
		base_material.params_cull_mode = base_material.CULL_BACK
	$"Game Space Cube".material_override = base_material

#the board says a space is (de/)selected -- what does that change for this space?
func _on_board_space_selected(valid: bool):
	if valid == true: #if the board says a space was selected...
		if space_is_selected == false: #and  it was not this space, then...
			yield(self.disable_space(),"completed") #make this space unselectable
			$"Game Space Cube/Game Space Area".input_ray_pickable = false
			$"Game Space Cube/Game Space Area/Game Space Hitbox".disabled = true
	else: #if the board says a space was deselected...
		yield(self.enable_space(),"completed") #make this space *selectable*, then...
		$"Game Space Cube/Game Space Area".input_ray_pickable = true
		$"Game Space Cube/Game Space Area/Game Space Hitbox".disabled = false
		deselect_space() #make sure this space is not selected

func _on_hud_disengage() -> void:
	if space_is_selected == true:
		deselect_space()
		print("selected space acks hud disengage")
	else:
		space_is_selectable = true #make this space *selectable*, then...
		$"Game Space Cube/Game Space Area".input_ray_pickable = true
		$"Game Space Cube/Game Space Area/Game Space Hitbox".disabled = false
		deselect_space() #make sure this space is not selected

#when a number is input from the HUD for this specific space
func _on_number_input(value: int):
	if space_is_selected == true: #confirm it is this space	
		if value == space_value: #If the new input value is correct, tell the world
			Events.emit_signal("space_win_state",self.name,true)
		else: #Otherwise, tell them the new input value is false...
			if space_input > 0: #Unless this is the first time, then don't emit the signal
				Events.emit_signal("space_win_state",self.name,false)		
		space_input = value #update the input value
		$"Label Sprite/Label Viewport/Game Space Label".text = str(space_input)
		adjust_size()
		Events.emit_signal("button_press","space")
		deselect_space() #deselect the space, then...
		Events.emit_signal("space_has_been_clicked_off") #tell the world this space is clicked off

#Update the space value and tell the board to update its size when a new game is instantiated
func _on_number_assign(space_name,value):
	if self.name == space_name:
		space_value = value
		space_input = 0
		$"Label Sprite/Label Viewport/Game Space Label".text = ""
		adjust_size()

#Tell the game board to adjust the size of this space
func adjust_size():
	if (space_value - space_input + 1) < 0:
		Events.emit_signal("adjust_space_size",self.name,space_value - space_input)
	elif (space_value - space_input + 1) == 0:
		Events.emit_signal("adjust_space_size",self.name,space_value - space_input)
	else:
		Events.emit_signal("adjust_space_size",self.name,space_value - space_input + 1)
