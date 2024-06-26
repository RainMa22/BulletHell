class_name BulletLongStyleManager extends StyleManager

const REGULAR: Shader = preload("res://src/bullet/DoodleBulletLong.gdshader")
const DOODLE: Shader = preload("res://src/bullet/DoodleBullet.gdshader")

var body_node: Sprite2D
var outline_node:Sprite2D
var outline_material: Material
var styleMaterial:ShaderMaterial

func _init(body_node: Sprite2D, outline_node: Sprite2D):
	super._init()
	self.body_node = body_node
	self.outline_node = outline_node
	outline_material = outline_node.material
	styleMaterial =  ShaderMaterial.new() 


func get_body_color() -> Color:
	return body_node.modulate
	
func get_outline_color() -> Color:
	return outline_node.modulate
	
func _is_valid():
	return is_instance_valid(body_node)

func doodle_style() -> void:
	body_node.visible = false;
	outline_material = outline_node.material
	outline_node.material = styleMaterial
	styleMaterial.set_shader(DOODLE)
	styleMaterial.set_shader_parameter("body_color", get_body_color())
	styleMaterial.set_shader_parameter("rim_color", get_outline_color())
	styleMaterial.set_shader_parameter("outline_color", get_outline_color())
	styleMaterial.set_shader_parameter("ID", Global.current_time)
	styleMaterial.set_shader_parameter("change_frequency", 5)

func default_style() -> void:
	body_node.visible = false;
	outline_material = outline_node.material
	outline_node.material = styleMaterial
	styleMaterial.set_shader(REGULAR)
	styleMaterial.set_shader_parameter("body_color", get_body_color())
	styleMaterial.set_shader_parameter("rim_color", get_outline_color())
	styleMaterial.set_shader_parameter("outline_color", get_outline_color())
	styleMaterial.set_shader_parameter("ID", Global.current_time)
	styleMaterial.set_shader_parameter("change_frequency", 5)

func _process(delta):
	#styleMaterial.set_shader_parameter("rand_val", rng.randf())
	pass
