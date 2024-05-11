class_name Game extends Node2D



#################################################################
# GAME                                                          #
# Main game logic, general organisation for gameplay exclusive. #
#################################################################



var player : Player
var boss : Boss

func _ready():
	Global.bullet_counter = 0 # Reset bullet counter when the game opens.

func _process(delta):
	pass

func boss_died():
	$Result.text = "[center]yippie!"

func player_died():
	$Result.text = "[center]skill issue"
