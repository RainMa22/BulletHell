extends Node2D


@onready var stats = $Control/Stats

# Called when the node enters the scene tree for the first time.
func _ready():
	var boss_beaten: int = Global.gameover_stats.get("boss_beaten");
	var personal_best: int = Global.get_peanut_butter();
	var personal_best_msg: String = "";
	if boss_beaten > personal_best:
		personal_best_msg = "New Personal Best!"
		personal_best = boss_beaten
		ConfigManager.current_config.personal_best = personal_best
		ConfigManager.save_config(ConfigManager.current_config)
	stats.text = stats.text.format(
		{"boss_beaten": boss_beaten,
		"plural": "" if boss_beaten == 1 else "es",
		"personal_best": personal_best,
		"personal_best_msg": personal_best_msg}
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
