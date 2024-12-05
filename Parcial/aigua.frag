#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D fons;
uniform sampler2D noise1;

uniform float time;

void main()
{
	vec2 noise = texture(noise1, vec2(vtexCoord.s + 0.08*time, vtexCoord.t + 0.07*time)).rg;
	noise = noise * vec2(.003, -.005);
	fragColor = texture(fons, vtexCoord + noise);
} 
