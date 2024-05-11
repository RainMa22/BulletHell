class_name SavesGlobal extends Node

const save_game_address = "user://savegame.save"

func save_game() -> void:
	var save_game = FileAccess.open(save_game_address, FileAccess.WRITE)
	
	var save_data = { # Create a save data object to serialise
		"boss_number": Global.current_boss
	}
	
	save_game.store_line(JSON.stringify(save_data))
	print("File saved.")

var loaded_boss_number : int = 0

func load_game() -> void:
	if not FileAccess.file_exists(save_game_address):
		print("No save file!")
		return
	
	var open_save_game = FileAccess.open(save_game_address, FileAccess.READ)
	
	var open_save_line = open_save_game.get_line() # Get the line.
	
	var json = JSON.new()
	
	var parse_result = json.parse(open_save_line)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", open_save_line, " at line ", json.get_error_line())
		return
	
	var open_save_data = json.parse_string(open_save_line)
	
	loaded_boss_number = open_save_data.boss_number
