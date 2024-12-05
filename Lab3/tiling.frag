#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D colorMap;
uniform int tiles;

void main()
{
    fragColor = texture(colorMap, vtexCoord);
}
