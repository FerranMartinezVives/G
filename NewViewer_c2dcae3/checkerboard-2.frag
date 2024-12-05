#version 330 core

in vec2 vtexCoord;

in vec4 frontColor;
out vec4 fragColor;

uniform float n = 16;

void main()
{
	float step = 1.0 / n;
	vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 grey = vec4(0.8, 0.8, 0.8, 1.0);
	int x = int(mod(vtexCoord.s / step, 2));
	int y = int(mod(vtexCoord.t / step, 2));
	if (x == y) fragColor = grey;
	else fragColor = black;
}
