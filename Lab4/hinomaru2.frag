#version 330 core

in vec2 vtexCoord;

out vec4 fragColor;

uniform bool classic = false;

void main()
{
	vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
	vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
	if (distance(vtexCoord, vec2(0.5, 0.5)) < 0.2) fragColor = red;
	else fragColor = white;
	
	if (!classic) {
		vec2 u = vtexCoord - vec2(0.5, 0.5);
		float angle = atan(u.t, u.s);
		if (mod(angle / (3.141592 / 16.0) + 0.5, 2) < 1) fragColor = red;
	}
}
