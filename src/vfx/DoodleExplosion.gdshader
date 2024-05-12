shader_type canvas_item;

// DOODLE EXPLOSION
// Explode!

// COLOURING
uniform vec4 body_color = vec4(1.); // inner radius
uniform vec4 rim_color = vec4(0,0,0,0); // outer radius
uniform vec4 outline_color = vec4(0,0,0,1.); // the circle around it

// NOISE
uniform float change_frequency = 5.0;
uniform float ID = 1.;

// RADIUS
uniform float body_radius_percentage = 0.35;

uniform float scale = 1.0;

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



// MAIN COLOUR SHADER
void fragment() {
	// UV and RADIUS, THETA calculations
	float x = UV.x-.5;
	float y = UV.y-.5;
	float radius = sqrt(x*x + y*y);
	float theta = (atan(y,x));
	
	// Variation calculations
	float alpha = 1.0;
	float variant_num = floor(TIME * change_frequency + ID);
	
	float offset = (noise(sin(theta*2.)*TAU-variant_num*7.))/10.;
	float offset2 = (noise(sin(theta*1.5)*TAU-variant_num*13.))/16.;
	
	
	
	// UV Percentages
	float max_body = body_radius_percentage + noise(variant_num*7.)/20. + offset;
	
	if(radius < max_body * scale) { // BODY
		COLOR = body_color;
	} else if (radius < (max_body) * scale + 0.01) {
		COLOR = rim_color;
	} else { // TRANSPARENCY
		COLOR = vec4(0.);
	}
}