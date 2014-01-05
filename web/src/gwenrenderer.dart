part of gwendart;

class CanvasFont extends GwenFont
{
  String _facename;
  int _size;
  bool _bSmooth;
  Object _data;
  
  String get FaceName => _facename;
  set FaceName(String value) { _facename = value; }
  int get Size => _size;
  set Size(int value) { _size = value; }
  bool get Smooth => _bSmooth;
  set Smooth(bool value) { _bSmooth = value; }
  Object get RendererData => _data;
  set RendererData(Object value) { _data = value; }
  
  double get RealSize => _size.toDouble();
  set RealSize(double value) { _size = value.toInt(); }

  CanvasFont(GwenRendererBase renderer, [String faceName="Arial", int size=10]) : super._internal(renderer, faceName, size)
  {
    _data = new Object();
    Smooth = false;
  }
  
  String get CssString => "${Size}px $FaceName";
  
}

class CanvasTexture extends GwenTexture
{
  String _name;
  Object _data;
  bool _bFailed;
  int _width;
  int _height;
  bool _hasData;
  
  String get Name => _name;
  set Name(String value) { _name = value; }
  Object get RenderData => _data;
  set RenderData(Object value) { _data = value; }
  bool get Failed => _bFailed;
  set Failed(bool value) { _bFailed = value; }
  int get Width=> _width;
  set Width(int value) { _width = value; }
  int get Height=>_height;
  set Height(int value) { _height = value; }
  bool get HasData => _hasData;
  set HasData (bool value)
  {
    _hasData = value;
  }
  
  CanvasTexture(GwenRendererBase renderer) : super._internal(renderer)
  {
    _data = new Object();
    _bFailed=false;
    _hasData=false;
  }
  

}


class GwenRenderer extends GwenRendererBase
{
  double _scale=1.0;
  CanvasRenderer _cvsr;
  
  GwenRenderer(CanvasRenderer cvsr)
  {
    _cvsr = cvsr;
  }
  double get Scale => _scale;
  set Scale(double value) { _scale = value; }
  

  
  void begin() 
  {
    _cvsr.start();
  }
  void end()
  {
    _cvsr.finish();
  }
  
  void flush()
  {
    //_cvsr.render();
   // _cvsr.flush();
  }
  Color get DrawColor => _cvsr.CurrentColor;
  set DrawColor(Color clr) { _cvsr.CurrentColor = clr; }
  
  Point<int> get RenderOffset => _renderOffset;
  set RenderOffset(Point<int> pt) { _renderOffset = pt; }
  
  Rectangle<int> get ClipRegion => _clipRegion;
  set ClipRegion (Rectangle<int> rect) { _clipRegion = rect; }
  
  ICacheToTexture get CTT { return null; }
  
  bool get ClipRegionVisible
  {
    return (_clipRegion.width != 0) || (_clipRegion.height != 0);
  }
  
  void drawLine(int x, int y, int a, int b) { _cvsr.drawLineOnCanvas(x, y, a, b); }
  void drawFilledRect(Rectangle<int> rect) { _cvsr.drawFilledRectOnCanvas(rect); }
  void startClip()
  {
     _cvsr.clipCanvas(_clipRegion);
  }
  void endClip()
  {
    _cvsr.unclipCanvas();
  }
  
  void loadTexture(GwenTexture t)
  {
     if(t.Name != null) t.HasData = true;
  }
  void loadTextureRaw(GwenTexture t, var pixelData)
  {
    throw new UnimplementedError("gwenrenderer.loadTextureRaw() not implemented");
  }
  void loadTextureStream(GwenTexture t, var stream)
  {
    throw new UnimplementedError("gwenrenderer.loadTextureStream() not implemented");
  }
  
  void freeTexture(GwenTexture t)
  {
    _cvsr.forgetTexture(t.Name);
  }
  
  
  void drawTexturedRect(GwenTexture t, Rectangle<int> targetRect, [double u1=0.0, double v1=0.0, double u2=1.0, double v2=1.0])
  {
    _cvsr.drawTexturedRectFromName(t.Name, targetRect, u1, v1, u2, v2);
  }
  
  void drawMissingImage(Rectangle<int> rect, [String name="(unknown)"])
  {
    _cvsr.drawMissingTexture(rect, name);
  }
  
  bool loadFont(GwenFont font) => true;
  void freeFont(GwenFont font)
  {
    
  }
  
  Point<int> measureText(GwenFont font, String text)
  {
    _cvsr.setFont(font.CssString);
    return _cvsr.measureText(text);
  }
  
  void renderText(GwenFont font, Point<int> position, String text)
  {
    _cvsr.setFont(font.CssString);
    _cvsr.drawTextOnCanvas( text, position.x, position.y );
  }
  
  void drawLinedRect(Rectangle<int> rect)
  {
     drawFilledRect(new Rectangle<int>(rect.left, rect.top, rect.width, 1));
     drawFilledRect(new Rectangle<int>(rect.left, rect.top+rect.height - 1, rect.width, 1));
     drawFilledRect(new Rectangle<int>(rect.left, rect.top, 1, rect.height));
     drawFilledRect(new Rectangle<int>(rect.left+rect.width-1, rect.top, 1, rect.height));
  }
  
  void drawPixel(int x, int y)
  {
    drawFilledRect(new Rectangle(x, y, 1, 1));
  }
  

  
  Color pixelColor(GwenTexture texture, int x, int y, Color defaultColor)
  {
    return _cvsr.getPixelColor(x, y);
  }
  
}