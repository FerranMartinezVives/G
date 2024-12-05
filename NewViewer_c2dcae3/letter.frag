#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

vec3 blue = vec3(0.4, 0.4, 0.8);
vec3 white = vec3(1.0, 1.0, 1.0);

bool isF() {	
	for (float t = 3.0/16.0; t <= 15.0/16.0; t += 1.0/8.0) {
		if (distance(vtexCoord, vec2(5.0/16.0, t)) <= 1.0/16.0) return true;
	}
	for (float s = 7.0/16.0; s <= 13.0/16.0; s += 1.0/8.0) {
		if (distance(vtexCoord, vec2(s, 15.0/16.0)) <= 1.0/16.0) return true;
	}
	for (float s = 7.0/16.0; s <= 11.0/16.0; s += 1.0/8.0) {
		if (distance(vtexCoord, vec2(s, 9.0/16.0)) <= 1.0/16.0) return true;
	}
	return false;
}

void main()
{
	if (isF()) fragColor = vec4(blue, 1.0);
    	else fragColor = vec4(white, 1.0);
}
