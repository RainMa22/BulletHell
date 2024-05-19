shader_type canvas_item;

// DOODLE BULLET LONG
// Long bullet design that has wiggly outline.

// COLOURING
uniform vec4 outline_color =  vec4(0.871,0.267,0.427,1.); // the circle around it
uniform vec4 body_color =  vec4(0.871,0.267,0.427,1.); // the circle around it

// NOISE
uniform lowp float change_frequency = 5.0;
uniform float ID = 1.;

// MATHEMATIQUES
// RANDOM GENERATOR
float rand(float x){
	return fract(sin(dot(x,0.1))*43758.5453);
}
// COSINE INTERPOLATION IMPLEMENTATION
float cosine_interpolation(float a, float b, float dist_from_a, float size){
	float x = dist_from_a/size;
	float x2 =(1.0-cos(PI*x))/2.;
	return a*(1.-x2)+b*(x2);
}
// 1 - dimension perlin - sort-of
float smoothrand(float x){
	float size = 2.;
	
	float a_point = floor(x/size)*size;
	float dist_from_a = x - a_point;
	float a_y = rand(a_point);
	float b_point = ceil(x/size)*size;
	float b_y = rand(b_point);

	return cosine_interpolation(abs(a_y),abs(b_y),dist_from_a, size);
}
// NOISE
float noise(float x) {
	return (smoothrand(x)+smoothrand(x*1.1)+smoothrand(x*0.9))/3.;
}

float triangle_width_from_y(float y){
	if(y>0.15 && y<0.7){
		float slope = (1./(0.15-0.7));
		return slope*(y-0.7);
	}
	return -128.;
}
// MAIN COLOUR SHADER
void fragment() {
	COLOR = vec4(0.);
	float x = UV.x - 0.5;
	float change_variant= floor(TIME*change_frequency+ID);
	float value= x - triangle_width_from_y(UV.y)/2.;
	float value2= x + triangle_width_from_y(UV.y)/2.;
	//float value= sin(UV.y*TAU*5.)*triangle_width_from_y(UV.y);
	if(value2 > noise(change_variant)/20.&&value < noise(change_variant)/20.){
		COLOR = outline_color;
	}
	//COLOR = vec4(value,value,value, 1.);
	//value= -sin(UV.y*128.+rand(change_variant)*TAU)*triangle_width_from_y(UV.y)-UV.x+0.5;
	//if(value>-0.1 && value<0.1){
		//COLOR = outline_color;
	//}
}