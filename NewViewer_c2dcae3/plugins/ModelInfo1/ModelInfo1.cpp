#include "ModelInfo1.h"
#include "glwidget.h"

void ModelInfo1::onPluginLoad()
{
	
}

void ModelInfo1::preFrame()
{
	
}

void ModelInfo1::postFrame()
{	
	int nObjs = 0, nPols = 0, nVtxs = 0;
	float trnglRate = 0;
	for (int i = 0; i < scene()->objects().size(); ++i) {
		++nObjs;
		const Object& obj = scene()->objects()[i];
		auto pols = obj.faces();
		nPols += pols.size();
		auto vtxs = obj.vertices();
		nVtxs += vtxs.size();
		float nTrngls = 0;
		for (int j = 0; j < pols.size(); ++j) {
			if (pols[i].numVertices() == 3) ++nTrngls;
		}
		trnglRate = nTrngls / pols.size();
	}
	cout << "nObjs = " << nObjs << ", nPols = " << nPols << ", nVtxs = " << nVtxs << ", trnglRate = " << trnglRate << endl;
}

void ModelInfo1::onObjectAdd()
{
	
}

bool ModelInfo1::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo1::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo1::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo1::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo1::mouseMoveEvent(QMouseEvent *)
{
	
}

