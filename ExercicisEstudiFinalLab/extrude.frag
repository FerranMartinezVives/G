#version 330 core

in vec3 gNormal;
out vec4 fragColor;

uniform mat3 normalMatrix;

void main()
{
    fragColor = vec4(normalize(normalMatrix * gNormal).zzz, 1.0);
}
