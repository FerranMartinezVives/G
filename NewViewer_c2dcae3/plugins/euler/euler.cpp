#include "euler.h"
#include "glwidget.h"

void Euler::printEuler(const Object& object) {
	F = object.faces().size();
	cout << "F=" << F << endl;
	V = object.vertices().size();
	cout << "V=" << V << endl;
	E = 0;
	for (int i = 0; i < F; i++) E += object.faces()[i].numVertices();
	E = E / 2;
	cout << "E=" << E << endl;
	cout << "X=" << F + V - E << endl;
}

void Euler::onPluginLoad()
{
	for (int i = 0; i < scene()->objects().size(); i++) printEuler(scene()->objects()[i]);
}

void Euler::preFrame()
{
	
}

void Euler::postFrame()
{
	
}

void Euler::onObjectAdd()
{
	for (int i = 0; i < scene()->objects().size(); i++) printEuler(scene()->objects()[i]);
}

bool Euler::drawScene()
{
	return false; // return true only if implemented
}

bool Euler::drawObject(int)
{
	return false; // return true only if implemented
}

bool Euler::paintGL()
{
	return false; // return true only if implemented
}

void Euler::keyPressEvent(QKeyEvent *)
{
	
}

void Euler::mouseMoveEvent(QMouseEvent *)
{
	
}

