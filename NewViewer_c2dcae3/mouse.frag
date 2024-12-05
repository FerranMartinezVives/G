#version 330 core

out vec4 fragColor;
in vec2 vtexCoord;

uniform int mode = 2;

const vec3 black = vec3(0.0);
const vec3 grey = vec3(0.8);
const vec3 skin = vec3(1.0, 0.8, 0.6);
const vec3 white = vec3(1.0, 1.0, 1.0);

bool isInFace() {
	float faceRadius = 0.35;
	vec2 faceCenter = vec2(0.5, 0.4);
	return distance(vtexCoord, faceCenter) <= faceRadius;
}

bool isInEars() {
	float earRadius = 0.2;
	vec2 leftCenter = vec2(0.2, 0.8);
	vec2 rightCenter = vec2(0.8, 0.8);
	return distance(vtexCoord, leftCenter) <= earRadius || 
	distance(vtexCoord, rightCenter) <= earRadius;
}

bool isInMouthSkin() {
	float mouthRadius = 0.15;
	vec2 mouthCenter = vec2(0.5, 0.3);
	vec2 transformCoord = vec2(vtexCoord.s/2.0 + 0.25, vtexCoord.t);
	return distance(transformCoord, mouthCenter) <= mouthRadius;
}

bool isInEyeSkin() {
	float eyeRadius = 0.075;
	vec2 leftCenter = vec2(0.45, 0.55);
	vec2 rightCenter = vec2(0.55, 0.55);
	vec2 transformCoord = vec2(vtexCoord.s, vtexCoord.t / 2.25 + 0.3);
	return distance(transformCoord, leftCenter) <= eyeRadius || 
	distance(transformCoord, rightCenter) <= eyeRadius;
}

bool isInEyeballs() {
	float eyeballRadius = 0.05;
	vec2 leftCenter = vec2(0.45, 0.55);
	vec2 rightCenter = vec2(0.55, 0.55);
	vec2 transformCoord = vec2(vtexCoord.s, vtexCoord.t / 2.25 + 0.3);
	return distance(transformCoord, leftCenter) <= eyeballRadius || 
	distance(transformCoord, rightCenter) <= eyeballRadius;
}

bool isInPupils() {
	float pupilRadius = 0.025;
	vec2 leftCenter = vec2(0.45, 0.525);
	vec2 rightCenter = vec2(0.55, 0.525);
	vec2 transformCoord = vec2(vtexCoord.s, vtexCoord.t / 2.25 + 0.3);
	return distance(transformCoord, leftCenter) <= pupilRadius || 
	distance(transformCoord, rightCenter) <= pupilRadius;
}

void main()
{	
	float radiOrelles = 0.2;
	vec2 centreOrellaEsquerra = vec2(0.2, 0.8);
	vec2 centreOrellaDreta = vec2(0.8, 0.8);
	float radiCara = 0.35;
	vec2 centreCara = vec2(0.5, 0.4);

	if (isInFace() || isInEars()) fragColor = vec4(black, 1.0);
	else fragColor = vec4(grey, 1.0);
	
	if (mode >= 1) {
		if (isInMouthSkin() || isInEyeSkin()) fragColor = vec4(skin, 1.0);
	}
	
	if (mode == 2) {
		if (isInEyeballs()) fragColor = vec4(white, 1.0);
		if (isInPupils()) fragColor = vec4(black, 1.0);
	}
}


