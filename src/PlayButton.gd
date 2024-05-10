extends Button


## TODO
func get_current_boss() -> int:
	return 0 #stub

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text.format({"current_boss": get_current_boss}) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
