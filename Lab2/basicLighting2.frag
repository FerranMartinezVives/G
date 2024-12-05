#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform mat3 normalMatrix;

in vec3 normalVec;

void main()
{
    vec3 N = normalize(normalMatrix * normalVec);
    fragColor = frontColor * N.z;
}
