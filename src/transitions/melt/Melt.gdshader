shader_type canvas_item;

uniform lowp float current_time = 1.0;
uniform bool swipe_up = false;

//void vertex() {
	//// Called for every vertex the material is visible on.
//}
// RANDOM GENERATOR
float rand(float x){
	return fract(sin(dot(x,0.1))*43758.5453);
}

vec4 texture2(sampler2D tex, vec2 uv){
	float x = uv.x;
	float y = uv.y;
	if (y <0. || y>1. || x<0. || y>1.){
		return vec4(0.0);
	}
	return texture(tex,uv);
}

void fragment() {
	float delta_y = (1.+rand(UV.x*TAU*100.))*-current_time;
	if(swipe_up){
		delta_y = (1.+rand(UV.x*TAU*100.))*current_time;
	}
	COLOR = texture2(TEXTURE, vec2(UV.x,UV.y+delta_y));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
