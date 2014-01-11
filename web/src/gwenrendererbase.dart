part of gwendart;

class Color
{
  static HashMap<int, Color> _map = new HashMap<int, Color>();
  static Color _getDefaultColor(int colorbits )
  {
    if(!_map.containsKey(colorbits))
    {
      Color clr = new Color.fromInt(colorbits);
      _map[colorbits] = clr;
    } 
    return _map[colorbits];
  }
  static Color get Red => _getDefaultColor(0xff0000);
  static Color get Green => _getDefaultColor(0x00ff00);
  static Color get Blue=> _getDefaultColor(0x0000ff);
  static Color get Yellow => _getDefaultColor(0xffff00);
  static Color get Purple => _getDefaultColor(0xff00ff);
  static Color get White => _getDefaultColor(0xffffff);
  static Color get Black => _getDefaultColor(0);
  static Color get Grey => _getDefaultColor(0x7f7f7f);
  
  int a;
  int r;
  int g;
  int b;
  Color.fromInt(int clrbits)
  {
    a=255;
    r= 255 & (clrbits >> 16);
    g= 255 & (clrbits >> 8);
    b= 255 & clrbits;
  }
  Color.rgb(int red, int green, int blue) {a=255; r = red; g=green; b=blue; }
  Color.argb(int alpha, int red, int green, int blue) { a=alpha;r = red; g=green; b=blue; }
  String get StyleString => "rgba($r, $g, $b, ${a/255.0})";
}


abstract class GwenRendererBase
{
  static const int MaxVerts = 1024;
  Point<int> _renderOffset;
  Rectangle<int> _clipRegion;
  double get Scale;
  set Scale(double);
  
  GwenRendererBase()
  {
    _renderOffset = new Point<int>(0, 0);
    Scale = 1.0; 
    if(CTT != null)
    {
      CTT.initialize();
    }
  }
  
  void begin() {}
  void end() {}
  Color get DrawColor;
  set DrawColor(Color);
  
  Point<int> get RenderOffset => _renderOffset;
  set RenderOffset(Point<int> pt) { _renderOffset = pt; }
  
  Rectangle<int> get ClipRegion => _clipRegion;
  set ClipRegion (Rectangle<int> rect) { _clipRegion = rect; }
  
  ICacheToTexture get CTT { return null; }
  
  bool get ClipRegionVisible
  {
    return (_clipRegion.width != 0) || (_clipRegion.height != 0);
  }
  
  void drawLine(int x, int y, int a, int b);
  void drawFilledRect(Rectangle<int> rect);
  void startClip();
  void endClip();
  void loadTexture(GwenTexture t);
  void loadTextureKnownSize(GwenTexture t, int width, int height);
  void loadTextureRaw(GwenTexture t, var pixelData);
  void loadTextureStream(GwenTexture t, var stream);
  void freeTexture(GwenTexture t);
  void drawTexturedRect(GwenTexture t, Rectangle<int> targetRect, [double u1=0.0, double v1=0.0, double u2=1.0, double v2=1.0]);
  void drawMissingImage(Rectangle<int> rect)
  {
    DrawColor = Color.Red;
    drawFilledRect(rect);
  }
  bool loadFont(GwenFont font) => false;
  void freeFont(GwenFont font);
  Point<int> measureText(GwenFont font, String text)
  {

    int xsize =  (font.Size * Scale * text.length * 0.4).toInt();
    int ysize =  (font.Size * Scale).toInt();
    Point<int> p = new Point<int>(xsize, ysize);
  }
  
  void renderText(GwenFont font, Point<int> position, String text)
  {
    double size = font.Size * Scale;
    for(int i=0; i<text.length; i++)
    {
        int chr = text.codeUnits[i];
        if(chr == " ".codeUnits[0])
          continue;
        int left = (position.x + i*size*0.4).round();
        int top = position.y;
        int width = (size * 0.4 - 1).round();
        int height = size.round();
        Rectangle<int> r = new Rectangle<int>(
            left, 
            top, 
            width, 
            height);
        drawFilledRect(r);
    }
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
    return defaultColor;
  }
  
  void drawShavedCornerRect(Rectangle<int> rectOrig, [bool slight = false])
  {
    // Draw INSIDE the w/h.
    Rectangle<int> rect = new Rectangle<int>(rectOrig.left, rectOrig.top, rectOrig.width-1, rectOrig.height-1);

    if (slight)
    {
      drawFilledRect(new Rectangle(rect.left + 1, rect.top, rect.width - 1, 1));
      drawFilledRect(new Rectangle(rect.left + 1, rect.top + rect.height, rect.width - 1, 1));

      drawFilledRect(new Rectangle(rect.left, rect.top + 1, 1, rect.height - 1));
      drawFilledRect(new Rectangle(rect.left + rect.width, rect.top + 1, 1, rect.height - 1));
      return;
    }

    drawPixel(rect.left + 1, rect.top + 1);
    drawPixel(rect.left + rect.width - 1, rect.top + 1);

    drawPixel(rect.left + 1, rect.top + rect.height - 1);
    drawPixel(rect.left + rect.width - 1, rect.top + rect.height - 1);

    drawFilledRect(new Rectangle(rect.left + 2, rect.top, rect.width - 3, 1));
    drawFilledRect(new Rectangle(rect.left + 2, rect.top + rect.height, rect.width - 3, 1));

    drawFilledRect(new Rectangle(rect.left, rect.top + 2, 1, rect.height - 3));
    drawFilledRect(new Rectangle(rect.left + rect.width, rect.top + 2, 1, rect.height - 3));
  }
  
  int translateX(int x)
  {
    int x1 = x + _renderOffset.x;
    return (x1*Scale).ceil();
  }
  
  int translateY(int y)
  {
    int y1 = y + _renderOffset.y;
    return (y1*Scale).ceil();
  }
  
  Rectangle translateRect(Rectangle r)
  {
    return new Rectangle(translateX(r.left), translateY(r.top), 
        translateX(r.right)-translateX(r.left), translateY(r.bottom)-translateY(r.top));
  }
  
  void translate(int x, int y)
  {
    throw new GwenErrorNotImplemented("GwenRendererBase.translate() not implemented.  Use translateX and translateY");
  }
  
  void AddRenderOffset(Rectangle offset)
  {
    _renderOffset = new Point(_renderOffset.x + offset.left, _renderOffset.y + offset.top);
  }
  
  void AddClipRegion(Rectangle<int> rect)
  {
    Rectangle<int> rect2 = new Rectangle<int>( _renderOffset.x, _renderOffset.y, rect.width, rect.height);
    //rect.X = m_RenderOffset.X;
    //rect.Y = m_RenderOffset.Y;

    int left = rect2.left;
    int top = rect2.top;
    int right = rect2.right;
    int bottom = rect2.bottom;
    int width=rect2.width;
    int height = rect2.height;
    Rectangle r = rect2;
    if (rect2.left < _clipRegion.left)
    {
      width -= (_clipRegion.left - r.left);
      right -= (_clipRegion.left - r.left);
      left = _clipRegion.left;
    }

    if (rect2.top < _clipRegion.top)
    {
      height -= (_clipRegion.top - r.top);
      bottom -= (_clipRegion.top - r.top);
      top = _clipRegion.top;
    }

    if (right > _clipRegion.right)
    {
      width = _clipRegion.right - left;
      right = left + width;
    }

    if (bottom > _clipRegion.bottom)
    {
      height = _clipRegion.bottom - top;
      bottom = top + height;
    }

    _clipRegion = new Rectangle<int>(left, top, width, height);
  }
  
  void notifyRedrawRequested();
  
  void SetCursor(CssCursor cursor);
  
}