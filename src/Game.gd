class_name Game extends Node2D



#################################################################
# GAME                                                          #
# Main game logic, general organisation for gameplay exclusive. #
#################################################################

var player : Player
var boss : Boss

var BOSS: Resource;
var sec_boss_died:=0;
const BOSS_RESPAWN_TIME_SECONDS:int =5;

func _ready():
	Global.bullet_counter = 0 # Reset bullet counter when the game opens.
	BOSS = await load("res://src/boss/Boss.tscn")
	boss = $GameContent/Boss
	player = $GameContent/Player
	player.health.on_died.connect(player_died)
	Global.current_game = self
	bind_boss_signals()

func bind_boss_signals():
	boss.health.on_died.connect(boss_died)

func _process(delta):
	pass

func boss_died():
	var tween: Tween = create_tween()
	for i in range(BOSS_RESPAWN_TIME_SECONDS):
		tween.tween_callback(update_countdown)
		tween.tween_interval(1.)
	tween.tween_callback(boss_respawn)
	
func update_countdown():
	$Result.text = "[center]yippie!\nBoss Respawning in {time} seconds".format(
		{"time":BOSS_RESPAWN_TIME_SECONDS-sec_boss_died})
	sec_boss_died = (sec_boss_died + 1) % BOSS_RESPAWN_TIME_SECONDS
		
	
func boss_respawn():
	var boss_transform = $GameContent/BossSpawnPoint.transform;
	boss = BOSS.instantiate()
	boss.transform = boss_transform
	$GameContent.add_child(boss)
	bind_boss_signals()
	$Result.text = ""

func player_died():
	$Result.text = "[center]skill issue"
