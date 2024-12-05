#include "ModelInfo2.h"
#include "glwidget.h"

void ModelInfo2::onPluginLoad()
{
	
}

void ModelInfo2::preFrame()
{
	
}

void ModelInfo2::postFrame()
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
	QFont font;
	font.setPixelSize(32);
	painter.begin(glwidget());
	painter.setFont(font);
	int x = 15;
	int y = 40;
	string result = "nObjs="+std::to_string(nObjs)+", nPols="+std::to_string(nPols)+", nVtxs="+std::to_string(nVtxs)+", trnglRate="+std::to_string(trnglRate);
	QString QStringResult = QString::fromStdString(result);
	painter.drawText(x, y, QStringResult);
	painter.end();
}

void ModelInfo2::onObjectAdd()
{
	
}

bool ModelInfo2::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo2::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo2::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo2::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo2::mouseMoveEvent(QMouseEvent *)
{
	
}

