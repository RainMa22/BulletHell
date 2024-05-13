class_name StyleManager extends Object


func _init():
	Global.style_changed.connect(self.on_style_change)

func on_style_change() -> void:
	match(Global.current_style):
		Global.Style.DOODLE: 
			doodle_style()
		_:
			default_style()
	
func _proc(delta):
	on_style_change();
func doodle_style():
	push_error("Must Override StyleManager.doodle_style()!")
	
func default_style():
	push_error("Must Override StyleManager.default_style()!")
