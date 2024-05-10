extends Button


## TODO
func get_current_boss() -> int:
	return 0 #stub

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self._button_pressed);
	self.text = self.text.format({"current_boss": get_current_boss()}) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
