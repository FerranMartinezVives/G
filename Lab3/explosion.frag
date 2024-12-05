#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D colorMap;

void main()
{
	vec4 color = texture(colorMap, vtexCoord);
	fragColor = color.a * color;
}
