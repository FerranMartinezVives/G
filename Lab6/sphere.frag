#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform mat3 normalMatrix;

uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position; en eye space
uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

uniform int mode = 2;

vec4 getPhong(vec3 vtexPosition, vec3 vtexNormal) {
	vec4 viewVertex = modelViewMatrix * vec4(vtexPosition, 1.0); 
	vec3 N = normalize(normalMatrix * vtexNormal);
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
	if (distance(vtexCoord, vec2(0.0, 0.0)) > 1) discard;
	float s = vtexCoord.s;
	float t = vtexCoord.t;
	vec3 P = vec3(s, t, sqrt(1 - pow(s, 2) - pow(t, 2)));
	vec3 N = P;
	if (mode == 0) {
    		fragColor = vec4(0.0, 0.0, 0.0, 1.0);
    	}
    	else if (mode == 1) {
    		fragColor = vec4(N.z, N.z, N.z, 1.0);
    	}
    	else if (mode == 2) {
    		fragColor = getPhong(P, N);
    	}
}
