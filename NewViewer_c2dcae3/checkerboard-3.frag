#version 330 core

in vec2 vtexCoord;

in vec4 frontColor;
out vec4 fragColor;

uniform float n = 8;

void main()
{
	float stepSquare = 1.0 / n;
	vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 grey = vec4(0.8, 0.8, 0.8, 1.0);
	float x = fract(vtexCoord.s / stepSquare);
	float y = fract(vtexCoord.t / stepSquare);
	if (x > 0.1 && y > 0.1) fragColor = grey;
	//0.1 perquè a raó de 9 la part negra ocupa un 10% (vtexCoord.s/.t té valors entre 0 i 1)
	else fragColor = black;
}
