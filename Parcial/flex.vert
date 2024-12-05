#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

const float ankle = 0.1;
const float knee = 0.48;

uniform float time;
uniform int mode = 1;

vec3 rot(vec3 P, float a, vec3 C, float cutoff) {
	mat4 rotateMatrix = mat4(
		vec4(1, 0, 0, 0),
		vec4(0, cos(a), sin(a), 0),
		vec4(0, -sin(a), cos(a), 0),
		vec4(0, 0, 0, 1)
	);
	//hi ha un problema amb les matrius de translació
	mat4 translateMatrix1 = mat4(
		vec4(0, 0, 0, 0),
		vec4(0, 0, 0, 0),
		vec4(0, 0, 0, 0),
		vec4(C.x-P.x, C.y-P.y, C.z-P.z, 1)
	);
	mat4 translateMatrix2 = mat4(
		vec4(1, 0, 0, 0),
		vec4(0, 1, 0, 0),
		vec4(0, 0, 1, 0),
		vec4(0, 0, 0, 1)
	);
	vec3 Q = vec3(translateMatrix2 * vec4(P, 1)).xyz;
	float t = smoothstep(cutoff-0.05, cutoff+0.05, vertex.y);
	return mix(P, Q, t);
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(N.z, N.z, N.z,1.0);
    vec3 transformedVertex = rot(vertex, 0.5*abs(sin(time)), vec3(0, ankle, 0), ankle);
    gl_Position = modelViewProjectionMatrix * vec4(transformedVertex, 1.0);
}
