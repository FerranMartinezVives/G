#include "isafloor.h"
#include "glwidget.h"

float Isafloor::computeLambda(const Object& object) {
	const vector<Vertex>& vertices = object.vertices();
	float usableObjectArea = 0;
	float objectArea = 0;
	for (const Face& face : object.faces()) {
		float dot = Vector::dotProduct(face.normal(), Vector(0, 0, 1));
		const Point& v0 = vertices[face.vertexIndex(0)].coord();
		const Point& v1 = vertices[face.vertexIndex(1)].coord();
		const Point& v2 = vertices[face.vertexIndex(2)].coord();
		Vector v = v1 - v0;
		Vector u = v2 - v0;
		float area = Vector::crossProduct(u, v).length() / 2.0;
		objectArea += area;
		if (dot > 0.7) usableObjectArea += area;
	}
	return usableObjectArea / objectArea;
}

void Isafloor::linkShaders() {
	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("isafloor.vert");
	cout << "VS log: " << vs->log().toStdString() << endl;
	
	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("isafloor.frag");
	cout << "FS log: " << fs->log().toStdString() << endl;
	
	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();
	cout << "Link log: " << program->log().toStdString() << endl;
}

void Isafloor::onPluginLoad()
{
	linkShaders();
	if (scene()->objects().size() > 0) {
		lambda = computeLambda(scene()->objects()[0]);
		cout << "TERRA: " << lambda << endl;
	}
}

void Isafloor::preFrame()
{
	program->bind();
	QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
	program->setUniformValue("modelViewProjectionMatrix", MVP);
	QMatrix3x3 N = camera()->viewMatrix().normalMatrix();
	program->setUniformValue("normalMatrix", N);
	program->setUniformValue("lambda", lambda);
}

void Isafloor::postFrame()
{
	
}

void Isafloor::onObjectAdd()
{
	if (scene()->objects().size() > 0) {
		lambda = computeLambda(scene()->objects()[0]);
		cout << "TERRA: " << lambda << endl;
	}
}

bool Isafloor::drawScene()
{
	return false; // return true only if implemented
}

bool Isafloor::drawObject(int)
{
	return false; // return true only if implemented
}

bool Isafloor::paintGL()
{
	return false; // return true only if implemented
}

void Isafloor::keyPressEvent(QKeyEvent *)
{
	
}

void Isafloor::mouseMoveEvent(QMouseEvent *)
{
	
}

