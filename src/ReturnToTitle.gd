extends Button
# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self._button_pressed)
	grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _button_pressed():
	Global.gameover_stats = {}
	get_tree().change_scene_to_file("res://scenes/Title.tscn")
