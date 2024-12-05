#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform float step = 0.2;

uniform mat3 normalMatrix;
uniform mat4 modelViewProjectionMatrix;

vec3 getCentroideTriangle(vec3 v1, vec3 v2, vec3 v3) {
	return (v1 + v2 + v3) / 3.0;
}

vec3 getNormal(vec3 v1, vec3 v2, vec3 v3) {
	vec3 v12 = normalize(v2 - v1);
	vec3 v13 = normalize(v3 - v1);
	return normalize(normalMatrix * normalize(cross(v12, v13)));
}

void emitCub(vec3 centre, float costat) {
	float radi = costat / 2;
	vec3 xyz = centre + vec3(-radi, -radi, -radi);
	vec3 xyZ = centre + vec3(-radi, -radi, radi);
	vec3 xYz = centre + vec3(-radi, radi, -radi);
	vec3 xYZ = centre + vec3(-radi, radi, radi);
	vec3 Xyz = centre + vec3(radi, -radi, -radi);
	vec3 XyZ = centre + vec3(radi, -radi, radi);
	vec3 XYz = centre + vec3(radi, radi, -radi);
	vec3 XYZ = centre + vec3(radi, radi, radi);
	
	gfrontColor = getNormal(xyz, xYz, Xyz).zzzz;
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1);
	EmitVertex();
	EndPrimitive();
	
	gfrontColor = getNormal(xyZ, XyZ, xYZ).zzzz;
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1);
	EmitVertex();
	EndPrimitive();
	
	gfrontColor = getNormal(xyz, xyZ, xYz).zzzz;
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1);
	EmitVertex();
	EndPrimitive();
	
	gfrontColor = getNormal(Xyz, XYz, XyZ).zzzz;
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1);
	EmitVertex();
	EndPrimitive();
	
	gfrontColor = getNormal(xyz, Xyz, xyZ).zzzz;
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1);
	EmitVertex();
	EndPrimitive();
	
	gfrontColor = getNormal(xYz, xYZ, XYz).zzzz;
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1);
	EmitVertex();
	EndPrimitive();
}

void main( void )
{
	vec3 centre = getCentroideTriangle(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz);
	emitCub(step * round(centre / step), step);
}
