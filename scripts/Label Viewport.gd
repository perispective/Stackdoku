tool
extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://assets/open-sans.regular.ttf")
	dynamic_font.size = 190
	$"Game Space Label".set("custom_fonts/font", dynamic_font)
