class_name Game extends Node2D



#################################################################
# GAME                                                          #
# Main game logic, general organisation for gameplay exclusive. #
#################################################################

var player : Player
var boss : Boss
var boss_name: RichTextLabel
const BOSS_NAME_TEMPLATE := "[center] The {0}Grandchild of Evil"

var BOSS: Resource;
var sec_boss_died:=0;
const BOSS_RESPAWN_TIME_SECONDS:int =5;

func _ready():
	Global.bullet_counter = 0 # Reset bullet counter when the game opens.
	BOSS = await load("res://src/boss/Boss.tscn")
	boss = $GameContent/Boss
	player = $GameContent/Player
	boss_name = $GameContent/BossBar/BossName
	player.health.on_died.connect(player_died)
	Global.current_game = self
	bind_boss_signals()
	update_boss_name()
	$HPBar.hp_init()
	$GameContent/BossBar/BossHPBar.hp_init()

func update_boss_name():
	var nth = ""
	if(Global.current_boss>1 && Global.current_boss <= 3):
		nth = "Great ".repeat(Global.current_boss-1)
	elif(Global.current_boss > 3):
		nth = "Great[font_size=10]x{0}[/font_size] ".format([Global.current_boss-1])
	boss_name.text = BOSS_NAME_TEMPLATE.format([nth])

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
	$Result.text = "[center]Yippie!\nBoss Respawning in {time} seconds".format(
		{"time":BOSS_RESPAWN_TIME_SECONDS-sec_boss_died})
	sec_boss_died = (sec_boss_died + 1) % BOSS_RESPAWN_TIME_SECONDS


signal boss_respawned
func boss_respawn():
	var boss_transform = $GameContent/BossSpawnPoint.transform;
	boss = BOSS.instantiate()
	boss.transform = boss_transform
	$GameContent.add_child(boss)
	bind_boss_signals()
	$Result.text = ""
	update_boss_name()
	boss_respawned.emit();

func player_died():
	$Result.text = "[center]Skill Issue"
	RenderingServer.frame_post_draw.connect(switch_to_game_end)
	

func switch_to_game_end():
	var viewport_image =get_tree().get_root().get_viewport().get_texture().get_image()
	var viewport_texture: Texture2D = ImageTexture.create_from_image(viewport_image)
	Global.gameover_stats = {
		"boss_beaten": Global.current_boss-1,
		"last_frame_texture": viewport_texture
	};
	Global.reset_progress()
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
	
