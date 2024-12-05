#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

uniform vec2 mousePosition;
uniform vec2 viewport;
uniform sampler2D jungla;
uniform float magnific = 3;

vec4 blurImage( in vec2 coords )
{
    float Pi = 6.28318530718; // Pi*2
    float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
    float Quality = 8.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
    float Size = 10.0; // BLUR SIZE (Radius)
   
    vec2 Radius = Size/viewport;

    vec4 Color = texture(jungla, coords);
    for( float d=0.0; d<Pi; d+=Pi/Directions)
    {
        float cd = cos(d);
        float sd = sin(d);
		for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
			Color += texture(jungla, coords+vec2(cd,sd)*Radius*i);		
        }
    }
    
    // Output to screen
    Color /= Quality * Directions - 15.0;
    return  Color;
}

bool isInCercleEsquerre(vec2 pixelCoords) {
	float radiCercles = 100.0;
	float gruixLinia = 5.0;
	vec2 centreCercleEsquerre = vec2(mousePosition.x - 80, mousePosition.y);
	return distance(centreCercleEsquerre, pixelCoords) >= radiCercles && 
		distance(centreCercleEsquerre, pixelCoords) <= radiCercles + gruixLinia;
}

bool isInCercleDret(vec2 pixelCoords) {
	float radiCercles = 100.0;
	float gruixLinia = 5.0;
	vec2 centreCercleDret = vec2(mousePosition.x + 80, mousePosition.y);
	return distance(centreCercleDret, pixelCoords) >= radiCercles && 
		distance(centreCercleDret, pixelCoords) <= radiCercles + gruixLinia;
}

bool isInBinoculars(vec2 pixelCoords) {
	float radiCercles = 100;
	vec2 centreCercleEsquerre = vec2(mousePosition.x - 80, mousePosition.y);
	vec2 centreCercleDret = vec2(mousePosition.x + 80, mousePosition.y);
	return distance(centreCercleEsquerre, pixelCoords) < radiCercles || 
		distance(centreCercleDret, pixelCoords) < radiCercles;
}

vec2 getPuntMagnificacio(vec2 pixelCoords) {
	vec2 A = mousePosition;
	vec2 B = pixelCoords;
	vec2 AB = pixelCoords - mousePosition;
	AB /= magnific;
	vec2 P = vec2(mousePosition.x + AB.x, mousePosition.y + AB.y);
	return P;
}

void main()
{
	vec2 vtexCoordPixels = vec2(vtexCoord.x * viewport.x, vtexCoord.y * viewport.y);
	bool isInCercEsq = isInCercleEsquerre(vtexCoordPixels);
	bool isInCercDret = isInCercleDret(vtexCoordPixels);
	bool isInBinoc = isInBinoculars(vtexCoordPixels);
	if ((isInCercEsq || isInCercDret) && !isInBinoc) fragColor = vec4(0, 0, 0, 1);
    	else if (isInBinoc) fragColor = texture(jungla, getPuntMagnificacio(vtexCoordPixels));
    	else fragColor = blurImage(vtexCoord);
}
