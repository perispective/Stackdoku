extends Node

signal board_space_is_selected(valid)

signal space_has_been_clicked_on(name)

signal space_has_been_clicked_off()

signal hud_disengage()

signal number_input(value)

signal adjust_space_size(space,value)

signal new_game_start()

signal number_assign(space,value)

signal space_win_state(space,valid)

signal game_won()

signal game_win_stats(moves,time)



#get rid of this one...
signal space_selected(valid)
