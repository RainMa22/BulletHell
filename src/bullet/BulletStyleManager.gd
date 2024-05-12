class_name BulletStyleManager extends Object

const DOODLE: Shader = preload("res://src/bullet/DoodleBullet.gdshader")
var rng: RandomNumberGenerator

var body_node: Sprite2D
var outline_node:Sprite2D
var outline_material: Material
var styleMaterial:ShaderMaterial

func _init(body_node: Sprite2D, outline_node: Sprite2D):
	self.body_node = body_node
	self.outline_node = outline_node
	outline_material = outline_node.material
	styleMaterial =  ShaderMaterial.new() 
	rng = Global.rng

func get_body_color() -> Color:
	return body_node.modulate
	
func get_outline_color() -> Color:
	return outline_node.modulate

func on_style_change() -> void:
	match(Global.current_style):
		Global.style.DOODLE:
			body_node.visible = false;
			outline_material = outline_node.material
			outline_node.material = styleMaterial
			styleMaterial.set_shader(DOODLE)
			styleMaterial.set_shader_parameter("color", get_body_color())
			styleMaterial.set_shader_parameter("outline", get_outline_color())
			#styleMaterial.set_shader_parameter("rand_val", rng.randf())
		_:
			body_node.visible = true;
			outline_node.material = outline_material;

func _process(delta):
	#styleMaterial.set_shader_parameter("rand_val", rng.randf())
	pass
