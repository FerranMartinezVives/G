#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float angle = 0.5;

const float minY = 1.45;
const float maxY = 1.55;

void main()
{	
	mat4 rotateMatrix = mat4(vec4(cos(angle), 0.0, -sin(angle), 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(sin(angle), 0.0, cos(angle), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
	vec3 rotatedVertex = (rotateMatrix * vec4(vertex, 1.0)).xyz;
	vec3 rotatedNormal = (rotateMatrix * vec4(normal, 1.0)).xyz;
	float t = smoothstep(minY, maxY, vertex.y);
	vec3 newVertex = mix(vertex, rotatedVertex, t);
	vec3 newNormal = mix(normal, rotatedNormal, t);
    	vec3 N = normalize(normalMatrix * newNormal);
    	frontColor = vec4(vec3(N.z),1.0);
    	gl_Position = modelViewProjectionMatrix * vec4(newVertex, 1.0);
}
