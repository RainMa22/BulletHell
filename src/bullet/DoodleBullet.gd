class_name DoodleBullet extends Bullet



#######################################
# DOODLEBULLET                        #
# The bullet 2, eletric boogalo.      #
#######################################

# TODO: Different visual styles/speeds/variations for bullets, different visuals corresponding to different effects.
var color: Color;
var outline: Color;
var shader = preload("res://src/bullet/DoodleBullet.gdshader")

func _init(color: Color = Color.WHITE, outline: Color= Color.BLACK):
	self.color = color;
	self.outline = outline;
	
# INITALISATION
func _ready():
	super._ready();
	self.material = ShaderMaterial.new()
	set_shader(self.shader)
	set_color(self.color)
	set_outline(self.outline)
	
func set_shader(shader:Shader):
	self.material.set_shader(shader);
	
func set_shader_param(property:String, value: Variant):
	self.material.set_shader_parameter(property, value)

func set_color(color: Color):
	self.color = color;
	set_shader_param("color", self.color);
	
func set_outline(color: Color):
	self.outline = color;
	set_shader_param("outline", self.outline);
	
