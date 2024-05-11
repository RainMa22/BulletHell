class_name Config extends Resource

##############################
# CONFIG                     #
# Saves boss, settings, etc. #
##############################

@export var master_volume : float = 1.0
@export var music_volume : float = 1.0
@export var sfx_volume : float = 1.0

@export var current_boss_number : int = 1

@export var allow_screen_shake : bool = true # Use for both SHAKE and KICK
@export var screen_shake_magnitude : float = 1.0

@export var use_parallax : bool = true # For the parallax movement
@export var show_background : bool = true # For the actual background
