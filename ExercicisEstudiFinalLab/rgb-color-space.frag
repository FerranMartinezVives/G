#version 330 core

in vec4 gfrontColor;
in vec2 gtexCoord;
out vec4 fragColor;

uniform int mode;

vec3 black = vec3(0, 0, 0);

void main()
{
    if (mode > 1 && (gtexCoord.s < 0.05 || gtexCoord.t < 0.05 || gtexCoord.s > 0.95 || gtexCoord.t > 0.95)) fragColor = vec4(black, 1);
    else fragColor = gfrontColor;
}
