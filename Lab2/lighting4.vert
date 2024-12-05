#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

uniform mat4 modelViewProjectionMatrix;

out vec2 vtexCoord;
out vec3 vtexNormal;
out vec3 vtexPosition;

void main()
{
    vtexNormal = normal;
    vtexPosition = vertex;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
