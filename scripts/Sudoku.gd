# This module is based on code by rrrtnx featured in the article
# "Program for Sudoku Generator" hosted on the site GeeksforGeeks
# Author: Ankur Trisal (ankur.trisal@gmail.com)
# Last updated 12 Nov 2021 - https://www.geeksforgeeks.org/program-sudoku-generator

extends Node

class_name Sudoku

const num_rows = 9
const num_cols = 9
const block_size = 3
var rng
var domains

#Initializing function for the sudoku board generator
func _init():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	domains = {}
	init()
	fill_diagonal()
	fill_remaining(1,4)
#	for key in domains.keys():
#		print(key + " = " + str(domains[key]))

#Create a domain key for every space on the game board
func init():
	for x in range(num_rows):
		for y in range (num_cols):
			domains [str(x + 1) + "," + str(y + 1)] = 0

#Fill in the diagonal game board boxes from top-left to bottom-right
func fill_diagonal():
	for x in [1,4,7]:
		fill_box(x,x)

#Fill in a 3x3 grid of cells starting at space row,col
func fill_box(row, col):
	var num
	for r in [0,1,2]:
		for c in [0,1,2]:
			num = rng.randi_range(1,9)
			while !unused_in_box(row,col,num):
				num = rng.randi_range(1,9)
			domains[str(row + r) + "," + str(col + c)] = num

#Checks whether a particular value is already used in this 3x3 box
func unused_in_box(row,col,num):
	for r in [0,1,2]:
		for c in [0,1,2]:
			if domains[str(row + r) + "," + str(col + c)] == num:
				return false
	return true

#Checks whether a particular value is already used in this row?
func unused_in_row(row,num):
	for c in range(1,10):
		if domains[str(row) + "," + str(c)] == num:
			return false
	return true

#Checks whether a particular value is already used in this column
func unused_in_col(col,num):
	for r in range(1,10):
		if domains[str(r) + "," + str(col)] == num:
			return false
	return true

#Checks against all three validity rules: row, col, and box
func check_if_safe(row,col,num):
	return (unused_in_box(row-((row-1)%block_size),col-((col-1)%block_size),num) && unused_in_col(col,num) && unused_in_row(row,num))

#Fills in the remaining cells after fill_diagonal is complete
func fill_remaining(row,col):
	
	if (col > 9 && row <= 9): #Check if the column has reached 9, if so, increment the row and set col = 1
		row = row + 1
		col = 1
	
	if (row > 9 && col > 9): #Check if we are have passed the last cell, if so, close the function out
		return true
	
	if (row <= 3): #Check if we're in block one, if so, push into block two
		if (col <= 3):
			col = 4
	elif (row <= 6): #Check if we're in block five, if so, push into block six
		if (col > 3 && col <= 6):
			col = 7
	else: #Check if we're about to enter block nine, if so, increment the row and set col = 1
		if (col == 7):
			row = row + 1
			col = 1
			if (row > 9):
				return true
	
	for num in range(1,10):
		if (check_if_safe(row,col,num)):
			domains[str(row) + "," + str(col)] = num
			if (fill_remaining(row,col + 1)):
				return true
			domains[str(row) + "," + str(col)] = 0
	
	return false

func get_grid():
	return domains
