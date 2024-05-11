class_name ConfigGlobal extends Node
# AUTOLOAD: ConfigManager

const SAVE_CONFIG_ADDRESS = "user://config.tres"

signal on_config_saved(config)
signal on_config_loaded(config)

var current_config : Config = Config.new()

func save_config(config : Config):
	ResourceSaver.save(config, SAVE_CONFIG_ADDRESS)
	on_config_saved.emit(config)
func load_config() -> void:
	current_config = load(SAVE_CONFIG_ADDRESS)
	if not current_config:
		current_config = Config.new()
	on_config_loaded.emit(current_config)
