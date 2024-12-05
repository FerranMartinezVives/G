#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D noise;
uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
	float noiseValue = texture(noise, vtexCoord).r;
	vec4 color1 = texture(texture1, vtexCoord);
	vec4 color2 = texture(texture2, vtexCoord);
	fragColor = mix(color1, color2, noiseValue);
}
