class_name BossHPBar extends ProgressBar

@onready var game: Game = get_tree().current_scene as Game
var text: RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	game.boss_respawned.connect(hp_init)

func hp_init():
	game.boss.health.on_health_healed.connect(changed)
	game.boss.health.on_health_damaged.connect(changed)
	game.boss.health.on_died.connect(died)
	changed(0)

func changed(change):
	value = float(game.boss.health.health) / float(game.boss.health.max_health)
	
func died():
	value = 0
