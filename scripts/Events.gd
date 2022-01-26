extends Node

# A board space was selected (true) or deselected (false)
signal board_space_is_selected(valid)

# A space [name] has been clicked on
signal space_has_been_clicked_on(name)

# Any space has been clicked off
signal space_has_been_clicked_off()

# HUD has been disengaged
signal hud_disengage()

# The number [value] has been input for a selected space
signal number_input(value)

# Space [space] should be updated to size based on its input number [value]
signal adjust_space_size(space,value)

# Start a new game
signal new_game_start()

# Assigns [value] as the correct number for [space]
signal number_assign(space,value)

# Space number [space] is in a win state (true) or non-win state (false)
signal space_win_state(space,valid)

# The current game has been won
signal game_won()

# When the game was won, it was with [moves] and [time]
signal game_win_stats(moves,time)

# Menu toggles
signal toggle_options_menu()
signal toggle_high_score_menu()
signal toggle_info_menu()
signal toggle_credits_menu()

# Clear the game board
signal clear_game_board()

# Toggle the sound on (true) or off (false)
signal toggle_sound(sound_on)

# Button press for sound effects based on [type]
signal button_press(type)
