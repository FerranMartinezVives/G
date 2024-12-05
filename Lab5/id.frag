#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D tex;

vec3 blue = vec3(0.0, 0.0, 1.0);
int n_digits = 8;
int[8] dni = int[8](4, 5, 1, 2, 9, 7, 5, 0);

void main()
{

	float x = mod(vtexCoord.x, 1.0/n_digits) * n_digits;
	vec4 C = texture(tex, vec2(dni[int(vtexCoord.x*n_digits)]/10.0+0.1*x, vtexCoord.y));
	if (C.a < 0.5) discard;
	fragColor = vec4(blue, 1.0);
	
	/*if (vtexCoord.x < 1.0/6.0) {		//4
		float x = mod(vtexCoord.x, 1.0/n_digits) * n_digits;
		vec4 C = texture(tex, vec2(dni[int(vtexCoord.x)]/10.0+0.1*x, vtexCoord.y));
		if (C.a < 0.5) discard;
	}
	else if (vtexCoord.x < 2.0/6.0) {	//5
		float x = (vtexCoord.x - 1.0/6.0) / (1.0/n_digits);
		vec4 C = texture(tex, vec2(5.0/10.0+0.1*x, vtexCoord.y));
		if (C.a < 0.5) discard;
	}
	else if (vtexCoord.x < 3.0/6.0) {	//1
		float x = (vtexCoord.x - 2.0/6.0) / (1.0/n_digits);
		vec4 C = texture(tex, vec2(1.0/10.0+0.1*x, vtexCoord.y));
		if (C.a < 0.5) discard;
	}
	else if (vtexCoord.x < 4.0/6.0) {	//2
		float x = (vtexCoord.x - 3.0/6.0) / (1.0/n_digits);
		vec4 C = texture(tex, vec2(2.0/10.0+0.1*x, vtexCoord.y));
		if (C.a < 0.5) discard;
	}
	else if (vtexCoord.x < 5.0/6.0) {	//9
		float x = (vtexCoord.x - 4.0/6.0) / (1.0/n_digits);
		vec4 C = texture(tex, vec2(9.0/10.0+0.1*x, vtexCoord.y));
		if (C.a < 0.5) discard;
	}
	else {					//7
		float x = mod(vtexCoord.x, 1.0/n_digits) * n_digits;
		vec4 C = texture(tex, vec2(dni[int(vtexCoord.x * n_digits)]/10.0+0.1*x, vtexCoord.y));
		if (C.a < 0.5) discard;
	}*/
   	fragColor = vec4(blue, 1.0);
}
