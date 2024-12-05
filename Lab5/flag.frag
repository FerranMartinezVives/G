#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

vec3 cyan = vec3(0.0, 1.0, 1.0);
vec3 red = vec3(1.0, 0.0, 0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);
vec3 green = vec3(0.0, 0.75, 0.0);
vec3 blue = vec3(0.0, 0.0, 0.75);
vec3 green2 = vec3(0.5, 0.75, 0.5);
vec3 white = vec3(1.0, 1.0, 1.0);

uniform int mode = 2;

bool isInsideSquare() {
	return vtexCoord.s >= 5.0/8.0 && vtexCoord.s <= 7.0/8.0 && vtexCoord.t >= 1.0/3.0 && vtexCoord.t <= 2.0/3.0;
}

bool isInsideCircle1() {
	return distance(vtexCoord, vec2(3.0/8.0, 0.5)) <= 1.0/3.0;
}

bool isInsideCircle2() {
	return distance(vtexCoord, vec2(0.5, 0.5)) <= 1.0/3.0;
}

void main()
{
	if (mode == 0) {
    		if (vtexCoord.s <= 0.5) fragColor = vec4(cyan, 1.0);
    		else if (vtexCoord.t >= 0.5) fragColor = vec4(red, 1.0);
    		else fragColor = vec4(yellow, 1.0);
    	}
    	else if (mode == 1) {
    		if (isInsideCircle2()) fragColor = vec4(red, 1.0);
    		else if (vtexCoord.t >= 2.0/3.0) fragColor = vec4(green, 1.0);
    		else if (vtexCoord.t <= 1.0/3.0) fragColor = vec4(blue, 1.0);
    		else fragColor = vec4(yellow, 1.0);
    	}
    	else if (mode == 2) {
    		if (isInsideSquare() || (isInsideCircle1() && !isInsideCircle2())) fragColor = vec4(white, 1.0);
    		else fragColor = vec4(green2, 1.0);
    	}
}
