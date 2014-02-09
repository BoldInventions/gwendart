import 'dart:html';
import 'src/gwendart.dart';
import 'testdockbase.dart';

const int USE_CANVAS2D_RENDERER = 0;
const int USE_WEBGL_CANVAS2D_RENDERER =1;

void main() {
//  querySelector("#sample_text_id")
//    ..text = "Click me!"
//    ..onClick.listen(reverseText);
  int iRendererSelect=USE_CANVAS2D_RENDERER;
  List<String> listTexturesToPreload = new List<String>();
  listTexturesToPreload.add("test16.png");
  listTexturesToPreload.add("redBrightMetallicC128.png");
  CanvasRenderer renderer=null;
  switch(iRendererSelect)
  {
    case USE_CANVAS2D_RENDERER:
      renderer = new CanvasRenderer(
          querySelector("#drawHere" ), 
          querySelector("#drawHere"),
          querySelector("#skinTextureCanvas"),
          TestDockBase.SkinImageFilename);
      break;
    case USE_WEBGL_CANVAS2D_RENDERER:
      renderer = new WebglCanvasRenderer(
          querySelector("#drawHere" ), 
          querySelector("#textureCanvas"),
          querySelector("#skinTextureCanvas"),
          TestDockBase.SkinImageFilename);
      break;
    default:
      throw new ArgumentError("Illegal rednderer code: $iRendererSelect");
  }


      renderer.preventBrowserKeyInterpretation();
  renderer.initialize(listTexturesToPreload).then((_) {
          GwenRenderer grenderer = new GwenRenderer(renderer);
          GwenTexturedSkinBase skin = new GwenTexturedSkinBase(grenderer, "DefaultSkin.png");
          GwenControlCanvas gcanvas = new GwenControlCanvas(skin);

          gcanvas.MouseInputEnabled = true;
          gcanvas.KeyboardInputEnabled = true;
          gcanvas.SetSize(renderer.Width, renderer.Height);
          gcanvas.ShouldDrawBackground = true;
          gcanvas.BackgroundColor = new Color.argb(255, 200, 165, 120);
          
          
          TestDockBase testDockBase = new TestDockBase(renderer, gcanvas, renderer.Width, renderer.Height);
          grenderer.connectEventsToGwenCanvas(gcanvas); 
          grenderer.notifyRedrawRequested();
          querySelector("#drawHere" ).focus();
        }
        , onError: (err, stacktrace) { print("Error in first render: $err, stacktrac: $stacktrace");});
    
    /* No need for this test any more */
    /*
    renderer.start();
    renderer.drawTexturedRectFromName("nehe.gif", new Rectangle<int>(35, 35, 100, 100));
    renderer.CurrentColor = Color.Blue;
    renderer.drawFilledRectOnCanvas(new Rectangle<int>(300, 300, 100, 100));
    renderer.CurrentColor = Color.Yellow;
    renderer.drawLinedRectOnCanvas(new Rectangle<int>(200, 200, 50, 70));
    renderer.CurrentColor = Color.Black;
    renderer.drawTextOnCanvas("Hello, Texture!",  310,  310);
    renderer.CurrentColor = Color.Red;
    renderer.drawLineOnCanvas(0, 0, 512, 512);

    renderer.finish();
    */

    //gcanvas.Invalidate();
    //gcanvas.Redraw();
    //gcanvas.RenderCanvas();
  

}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
