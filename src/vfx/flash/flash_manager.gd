class_name FlashManager extends Node

@export var flashShader: Resource

class FlashEvent:
	var Target : CanvasItem
	var TimeRemaining : float
	var PreviousMaterial : Material
	
	func subtract_time(delta):
		self.TimeRemaining -= delta
	func start_flash(sha):
		var newMat = ShaderMaterial.new()
		newMat.set_shader(sha)
		self.Target.set_material(newMat)
		self.Target.material.set_shader_parameter("whitening", 1)
		
	func reset():
		if self.Target != null:
			self.Target.material = self.PreviousMaterial

var list_of_ongoing_flashes = []

func flash(target: CanvasItem, time: float):
	var newFlash = FlashEvent.new()
	newFlash.Target = target
	newFlash.TimeRemaining = time
	
	list_of_ongoing_flashes.append(newFlash)
	newFlash.start_flash(flashShader)

func _process(delta):
	var list_of_remove_flashes = []
	
	for f in list_of_ongoing_flashes:
		f.subtract_time(delta)
		if f.TimeRemaining <= 0.0:
			list_of_remove_flashes.append(f)
			f.reset()
	
	for f in list_of_remove_flashes:
		list_of_ongoing_flashes.remove_at(list_of_ongoing_flashes.find(f))
