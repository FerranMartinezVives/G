#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

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

uniform sampler2D positionMap;
uniform sampler2D normalMap1;

uniform int mode = 3;

vec4 getPhong(vec3 v, vec3 n, vec4 mDif) {
	vec4 viewVertex = modelViewMatrix * vec4(v, 1.0); 
	vec3 N = n;
	vec3 V = normalize(-viewVertex.xyz);
	vec3 L = normalize(lightPosition.xyz - viewVertex.xyz);
	vec3 R = 2 * dot(N, L) * N - L;
	
	vec4 Ambi = matAmbient * lightAmbient;
	vec4 Diff = mDif * lightDiffuse * max(0.0, dot(N, L));
	vec4 Spec = vec4(0.0, 0.0, 0.0, 0.0);
	if (dot(N, L) > 0.0) Spec = matSpecular * lightSpecular * pow(max(0.0, dot(R, V)), matShininess);
	return Ambi + Diff + Spec;
}

void main()
{
	vec2 newTexCoord = 0.004 + ((vertex.xy+1) / 2) * (0.996-0.004);
	vec4 colorTex1 = texture(positionMap, newTexCoord);
	vec4 colorTex2 = texture(normalMap1, newTexCoord);
	vec3 newN = normalize(normalMatrix * (colorTex2.rgb * 2 - 1));
	if (mode == 0) {
		frontColor = vec4(colorTex1.rgb, 1);
	}
	else if (mode == 1) {
		frontColor = vec4(colorTex1.rgb*newN.z, 1);
	}
	else if (mode == 2) {
		frontColor = getPhong(colorTex1.rgb, newN, matDiffuse);
	}
	else if (mode == 3) {
		frontColor = getPhong(colorTex1.rgb, newN, vec4(colorTex1.rgb, 1));
	}
    gl_Position = modelViewProjectionMatrix * vec4(colorTex1.rgb, 1);
}
