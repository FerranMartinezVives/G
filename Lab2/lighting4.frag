#version 330 core

out vec4 fragColor;

in vec3 vtexNormal;
in vec3 vtexPosition;

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

vec4 getPhong() {
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
    fragColor = getPhong();
}
