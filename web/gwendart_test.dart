
import 'src/gwendart.dart';
import 'testdockbase.dart';

const int USE_CANVAS2D_RENDERER = 0;
const int USE_WEBGL_CANVAS2D_RENDERER =1;
const String TAG_DRAWCANVAS = "#drawHere";
const String FNAME_SKIN_TEXTURE = "";

void main()
{
  startGwen(TAG_DRAWCANVAS, 
      TestDockBase.SkinImageFilename,
      512, 
      512,
      TestDockBase.getListOfTextureFilenames(),
      TestDockBase.createTestDocBase);
}



