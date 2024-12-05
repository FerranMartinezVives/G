#version 330 core

in vec2 vtexCoord;

out vec4 fragColor;


void main()
{
	vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
	vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
	if (distance(vtexCoord, vec2(0.5, 0.5)) < 0.2) fragColor = red;
	else fragColor = white;
}
