shader_type canvas_item;

uniform vec4 color = vec4(1.);
uniform vec4 outline = vec4(0,0,0,1.);
uniform float changes_per_second = 1.0;
uniform float ID = 1.;

float rand(float x){
	return fract(sin(dot(x,0.1))*43758.5453);
	//return fract(sin(dot(x,rand_val)));
}



float cosine_interpolation(float a, float b, float dist_from_a, float size){
	float x = dist_from_a/size;
	float x2 =(1.0-cos(PI*x))/2.;
	return a*(1.-x2)+b*(x2);
	//return (a-b)*x;
}

//1 - dimension perlin - sort-of
float smoothrand(float x){
	float size = 2.;
	
	float a_point = floor(x/size)*size;
	float dist_from_a = x - a_point;
	float a_y = rand(a_point);
	float b_point = ceil(x/size)*size;
	float b_y = rand(b_point);

	return cosine_interpolation(abs(a_y),abs(b_y),dist_from_a, size);
}

float noise(float x) {
	return (smoothrand(x)+smoothrand(x*1.1)+smoothrand(x*0.9))/3.;
}

void fragment() {
	float x = UV.x-.5;
	float y = UV.y-.5;
	float radius = sqrt(x*x + y*y);
	float theta = (atan(y,x));
	
	float alpha = 1.0;
	float variant_num = floor(TIME*changes_per_second + ID);
	float body = .2 + noise(variant_num*7.)/20.;
	float outline_size = .4 + noise(variant_num*13.)/40.;
	float offset = (noise(sin(theta*2.)*TAU-variant_num*7.))/10.;
	float offset2 = (noise(sin(theta*1.5)*TAU-variant_num*13.))/16.;
	if(radius < body + offset){
		COLOR = color;
	
	} else if(radius < outline_size + offset2){
		//alpha = 1.0;
		COLOR = outline;
	} else {
		COLOR = vec4(0.);
	}
	//COLOR = vec4(UV, 1, 1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
