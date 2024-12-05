#include "DrawSmooth.h"
#include "glwidget.h"
#include <cassert>
#include <cmath>

DrawSmooth::~DrawSmooth() {
  cleanUp();
}

void DrawSmooth::onSceneClear()
{
    cleanUp();
}

void DrawSmooth::cleanUp()
{
  GLWidget &g = *glwidget();
  g.glDeleteBuffers(coordBuffers.size(),  &coordBuffers[0]);
  g.glDeleteBuffers(normalBuffers.size(), &normalBuffers[0]);
  g.glDeleteBuffers(stBuffers.size(),  &stBuffers[0]);
  g.glDeleteBuffers(colorBuffers.size(),  &colorBuffers[0]);
  g.glDeleteVertexArrays(VAOs.size(), &VAOs[0]);
  coordBuffers.clear();
  normalBuffers.clear();
  stBuffers.clear();
  colorBuffers.clear();
  VAOs.clear();
  numIndices.clear();
}

bool DrawSmooth::drawObject(int i)
{
  GLWidget &g = *glwidget();
  g.makeCurrent();
  g.glBindVertexArray(VAOs[i]);
  g.glDrawArrays(GL_TRIANGLES, 0, numIndices[i]);
  g.glBindVertexArray(0);
  return true;
}

bool DrawSmooth::drawScene()
{
  GLWidget &g = *glwidget();
  g.makeCurrent();
  GLint program;
  g.glGetIntegerv(GL_CURRENT_PROGRAM, &program);
  GLint loc = g.glGetUniformLocation(program,"objectID");
  for(unsigned int i=0; i<VAOs.size(); i++) {
    // for each buffer (that is, for each object)
    if (loc>=0) g.glUniform1i(loc, i);
	  drawObject(i);
  }
  return true;
}

void DrawSmooth::onPluginLoad()
{
  for(unsigned int i=0; i<scene()->objects().size(); i++)
    addVBO(i);
}

void DrawSmooth::onObjectAdd()
{
  addVBO( scene()->objects().size() - 1 );
}

void DrawSmooth::addVBO(unsigned int currentObject) {
	const Object& object = scene()->objects()[currentObject];
	const vector<Vertex>& objectVertices = object.vertices();
	const vector<Vector>& objectNormals = object.vertNormals();
	const vector<pair<float, float>>& objectTextureCoordinates = object.vertTexCoords();
	unsigned int faceCount = object.faces().size();
	unsigned int vertexCount = object.vertices().size();
	vector<float> coordinates;
	vector<float> normals;
	vector<float> colors;
	vector<float> textureCoordinates;
	
	vector<int> indices;
	vector<Vector> normalSums(vertexCount, Vector(0, 0, 0));
	vector<int> vertexDegrees(vertexCount, 0);
	
	for (const Face& face : object.faces()) {
		for (int i = 0; i < 3; i++) {
	 		int index = face.vertexIndex(i);
			const auto vertexNormal = objectNormals[face.normalIndex(i)];
			indices.push_back(index);
			normalSums[index] += vertexNormal;
			vertexDegrees[index] += 1;
		}
	}
	
	for (unsigned int i = 0; i < vertexCount; i++) {
		const Point& vertexCoordinates = objectVertices[i].coord();
		Vector vertexNormal = normalSums[i] / vertexDegrees[i];
		const pair<float, float>& vertexTextureCoordinates = objectTextureCoordinates[i];
		coordinates.push_back(vertexCoordinates.x());
		coordinates.push_back(vertexCoordinates.y());
		coordinates.push_back(vertexCoordinates.z());
		normals.push_back(vertexNormal.x());
		normals.push_back(vertexNormal.y());
		normals.push_back(vertexNormal.z());
		colors.push_back(fabs(vertexNormal.x()));
		colors.push_back(fabs(vertexNormal.y()));
		colors.push_back(fabs(vertexNormal.z()));
		textureCoordinates.push_back(vertexTextureCoordinates.first);
		textureCoordinates.push_back(vertexTextureCoordinates.second);
	}
	
	assert(coordinates.size() == 3*vertexCount);
	assert(normals.size() == 3*vertexCount);
	assert(colors.size() == 3*vertexCount);
	assert(textureCoordinates.size() == 2*vertexCount);
	assert(indices.size() == 3*faceCount);
	
	// Step 2: Create VAO and empty buffers (coords, normals, ...)
	GLWidget& g = *glwidget();
  	GLuint VAO;
  	g.glGenVertexArrays(1, &VAO);
  	VAOs.push_back(VAO);
  	g.glBindVertexArray(VAO);
  
  	GLuint coordBufferID;
  	g.glGenBuffers(1, &coordBufferID);
  	coordBuffers.push_back(coordBufferID);
  
  	GLuint normalBufferID;
  	g.glGenBuffers(1, &normalBufferID);
  	normalBuffers.push_back(normalBufferID);
  
  	GLuint stBufferID;
  	g.glGenBuffers(1, &stBufferID);
 	stBuffers.push_back(stBufferID);
  
 	GLuint colorBufferID;
  	g.glGenBuffers(1, &colorBufferID);
  	colorBuffers.push_back(colorBufferID);
  	
  	GLuint indexBufferID;
  	g.glGenBuffers(1, &indexBufferID);
  	indexBuffers.push_back(indexBufferID);
  	
  	numIndices.push_back(3*faceCount);
  	
  	// Step 3: Define VBO data (coords, normals, ...)
  	g.glBindBuffer(GL_ARRAY_BUFFER, coordBufferID);
  	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*coordinates.size(), &coordinates[0], GL_STATIC_DRAW);
  	g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0); 
  	g.glEnableVertexAttribArray(0);

  	g.glBindBuffer(GL_ARRAY_BUFFER, normalBufferID);
  	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*normals.size(), &normals[0], GL_STATIC_DRAW);
  	g.glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, 0);
 	g.glEnableVertexAttribArray(1);

  	g.glBindBuffer(GL_ARRAY_BUFFER, colorBufferID);
  	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*colors.size(), &colors[0], GL_STATIC_DRAW);
  	g.glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, 0);
  	g.glEnableVertexAttribArray(2);

  	g.glBindBuffer(GL_ARRAY_BUFFER, stBufferID);
  	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*textureCoordinates.size(), &textureCoordinates[0], GL_STATIC_DRAW);
  	g.glVertexAttribPointer(3, 2, GL_FLOAT, GL_FALSE, 0, 0);
  	g.glEnableVertexAttribArray(3);
  
  	g.glBindBuffer(GL_ARRAY_BUFFER,0);
  	
  	g.glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffers[currentObject]);
  	g.glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(int)*indices.size(), &indices[0], GL_STATIC_DRAW);
  	g.glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
  	
  	g.glBindVertexArray(0);
}
