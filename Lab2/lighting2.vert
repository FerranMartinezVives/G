#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform mat4 modelViewMatrix;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;
uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

vec4 getPhong() {
	vec4 viewVertex = modelViewMatrix * vec4(vertex, 1.0); 
	vec3 N = normalize(normalMatrix * normal);
	vec3 V = normalize(-viewVertex.xyz);
	vec3 L = normalize(lightPosition.xyz - viewVertex.xyz);
	vec3 R = 2 * dot(N, L) * N - L;
	
	vec4 Ambi = matAmbient * lightAmbient;
	vec4 Diff = matDiffuse * lightDiffuse * max(0.0, dot(N, L));
	vec4 Spec = vec4(0.0, 0.0, 0.0, 0.0);
	if (dot(N, L) > 0.0) Spec = matSpecular * lightSpecular * pow(max(0.0, dot(R, V)), matShininess);
	return Ambi + Diff + Spec;
}

void main()
{
    frontColor = getPhong();
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
