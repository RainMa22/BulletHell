class_name StyleManager extends Node2D


func _init():
	Global.style_changed.connect(self.on_style_change)

func check_validity():
	var result = !_is_valid()
	if(result):
		Global.style_changed.disconnect(self.on_style_change)
		queue_free()
	return result

func on_style_change() -> void:
	if(check_validity()): return
	match(Global.current_style):
		Global.Style.DOODLE: 
			doodle_style()
		_:
			default_style()
	
func _proc(delta):
	on_style_change();
	
func _is_valid() -> bool:
	assert(false, "Must Override StyleManager._is_valid()!")
	return true

func doodle_style():
	assert(false,"Must Override StyleManager.doodle_style()!")
	
func default_style():
	assert(false,"Must Override StyleManager.default_style()!")
