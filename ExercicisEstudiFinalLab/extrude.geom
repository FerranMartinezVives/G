#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vNormal[];
out vec3 gNormal;

uniform mat3 normalMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform float d = 1.5;

vec3 getPromig(vec3 n0, vec3 n1, vec3 n2) {
	return (n0 + n1 + n2) / 3.0;
}

void main( void )
{
	vec3 N = getPromig(vNormal[0], vNormal[1], vNormal[2]);
	
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = gl_in[1].gl_Position.xyz;
	vec3 v2 = gl_in[2].gl_Position.xyz;
	vec3 u0 = v0 + d * N;
	vec3 u1 = v1 + d * N;
	vec3 u2 = v2 + d * N;
	
	//cara1
	gNormal = -N;
	gl_Position = modelViewProjectionMatrix * vec4(v0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	EmitVertex();
	EndPrimitive();
	
	//cara2
	gNormal = N;
	gl_Position = modelViewProjectionMatrix * vec4(u0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u2, 1);
	EmitVertex();
	EndPrimitive();
	
	//cara3
	gNormal = normalize(cross(v1 - v0, u0 - v0));
	gl_Position = modelViewProjectionMatrix * vec4(v0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u1, 1);
	EmitVertex();
	EndPrimitive();
	
	//cara4
	gNormal = normalize(cross(v2 - v0, u0 - v0));
	gl_Position = modelViewProjectionMatrix * vec4(v0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u2, 1);
	EmitVertex();
	EndPrimitive();
	
	//cara5
	gNormal = normalize(cross(v2 - v1, u1 - v1));
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(u2, 1);
	EmitVertex();
	EndPrimitive();
}
