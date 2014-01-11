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
  static HashMap<int, String> KeyXlateDict=new HashMap<int, String>();
  static HashMap<int, String> KeyXlateDictShift=new HashMap<int, String>();
  static HashMap<int, String> KeyXlateDictCtrl=new HashMap<int, String>();
  
  double _scale=1.0;
  CanvasRenderer _cvsr;
  GwenControlCanvas _gwenCanvas=null;
  int lastKnownMouseX=0;
  int lastKnownMouseY=0;
  int _frameNumber;
  
  Queue<DateTime> RenderRequestQueue = new Queue<DateTime>();
  
  GwenRenderer(CanvasRenderer cvsr)
  {
    _cvsr = cvsr;
    _frameNumber=0;
    _initKeyXlateDict();
    InputHandler.init();
  }
  
  void _initKeyXlateDict()
  {
    HashMap<int, String> d = GwenRenderer.KeyXlateDict;
    d[KeyCode.A]= "a";
    d[KeyCode.APOSTROPHE]="`";
    d[KeyCode.B]="b";
    d[KeyCode.BACKSLASH]="\\";
    d[KeyCode.BACKSPACE]="\b";
    d[KeyCode.C]="c";
    d[KeyCode.CLOSE_SQUARE_BRACKET]="]";
    d[KeyCode.COMMA]=",";
    d[KeyCode.D]="d";
    d[KeyCode.DASH]="-";
    d[KeyCode.E]="e";
    d[KeyCode.ENTER]="\r";
    d[KeyCode.EIGHT]="8";
    d[KeyCode.EQUALS]="=";
    d[KeyCode.ESC]="\x1b";
    d[KeyCode.F]="f";
    d[KeyCode.FIVE]="5";
    d[KeyCode.FOUR]="4";
    d[KeyCode.G]='g';
    d[KeyCode.H]='h';
    d[KeyCode.I]='i';
    d[KeyCode.J]='j';
    d[KeyCode.K]='k';
    d[KeyCode.L]='l';
    d[KeyCode.M]='m';
    d[KeyCode.N]='n';
    d[KeyCode.NINE]='9';
    d[KeyCode.NUM_FIVE]='5';
    d[KeyCode.NUM_FOUR]='4';
    d[KeyCode.NUM_THREE]='3';
    d[KeyCode.NUM_TWO]='2';
    d[KeyCode.NUM_ONE]='1';
    d[KeyCode.NUM_ZERO]='0';
    d[KeyCode.NUM_SIX]='6';
    d[KeyCode.NUM_SEVEN]='7';
    d[KeyCode.NUM_EIGHT]='8';
    d[KeyCode.NUM_NINE]='9';
    d[KeyCode.NUM_DIVISION]='/';
    d[KeyCode.NUM_MULTIPLY]='*';
    d[KeyCode.NUM_MINUS]='-';
    d[KeyCode.NUM_PLUS]='+';
    d[KeyCode.O]='o';
    d[KeyCode.ONE]='1';
    d[KeyCode.P]='p';
    d[KeyCode.PERIOD]='.';
    d[KeyCode.Q]='q';
    d[KeyCode.QUESTION_MARK]='?';
    d[KeyCode.S]='s';
    d[KeyCode.SEVEN]='7';
    d[KeyCode.SINGLE_QUOTE]="'";
    d[KeyCode.SIX]='6';
    d[KeyCode.SLASH]='/';
    d[KeyCode.SPACE]=' ';
    d[KeyCode.T]='t';
    d[KeyCode.TAB]='\t';
    d[KeyCode.THREE]='3';
    d[KeyCode.TILDE]='~';
    d[KeyCode.TWO]='2';
    d[KeyCode.U]='u';
    d[KeyCode.V]='v';
    d[KeyCode.X]='x';
    d[KeyCode.Y]='y';
    d[KeyCode.Z]='z';
    d[KeyCode.ZERO]='0';
    
    d = GwenRenderer.KeyXlateDictShift;
    d[KeyCode.A]= "A";
    d[KeyCode.APOSTROPHE]="~";
    d[KeyCode.B]="B";
    d[KeyCode.BACKSLASH]="|";
    d[KeyCode.BACKSPACE]="\b";
    d[KeyCode.C]="C";
    d[KeyCode.CLOSE_SQUARE_BRACKET]="}";
    d[KeyCode.COMMA]='<';
    d[KeyCode.D]="D";
    d[KeyCode.DASH]='_';
    d[KeyCode.E]="E";
    d[KeyCode.ENTER]="\r";
    d[KeyCode.EIGHT]="*";
    d[KeyCode.EQUALS]="+";
    d[KeyCode.ESC]="\x1b";
    d[KeyCode.F]="F";
    d[KeyCode.FIVE]="%";
    d[KeyCode.FOUR]="\$";
    d[KeyCode.G]='G';
    d[KeyCode.H]='H';
    d[KeyCode.I]='I';
    d[KeyCode.J]='J';
    d[KeyCode.K]='K';
    d[KeyCode.L]='L';
    d[KeyCode.M]='M';
    d[KeyCode.N]='N';
    d[KeyCode.NINE]='(';
    d[KeyCode.NUM_FIVE]='5';
    d[KeyCode.NUM_FOUR]='4';
    d[KeyCode.NUM_THREE]='3';
    d[KeyCode.NUM_TWO]='2';
    d[KeyCode.NUM_ONE]='1';
    d[KeyCode.NUM_ZERO]='0';
    d[KeyCode.NUM_SIX]='6';
    d[KeyCode.NUM_SEVEN]='7';
    d[KeyCode.NUM_EIGHT]='8';
    d[KeyCode.NUM_NINE]='9';
    d[KeyCode.NUM_DIVISION]='/';
    d[KeyCode.NUM_MULTIPLY]='*';
    d[KeyCode.NUM_MINUS]='-';
    d[KeyCode.NUM_PLUS]='+';
    d[KeyCode.O]='O';
    d[KeyCode.ONE]='!';
    d[KeyCode.P]='P';
    d[KeyCode.PERIOD]='>';
    d[KeyCode.Q]='Q';
    d[KeyCode.QUESTION_MARK]='?';
    d[KeyCode.S]='S';
    d[KeyCode.SEVEN]='&';
    d[KeyCode.SINGLE_QUOTE]='"';
    d[KeyCode.SIX]='^';
    d[KeyCode.SLASH]='?';
    d[KeyCode.SPACE]=' ';
    d[KeyCode.T]='T';
    d[KeyCode.TAB]='\t';
    d[KeyCode.THREE]='#';
    d[KeyCode.TILDE]='~';
    d[KeyCode.TWO]='@';
    d[KeyCode.U]='U';
    d[KeyCode.V]='V';
    d[KeyCode.X]='X';
    d[KeyCode.Y]='Y';
    d[KeyCode.Z]='Z';
    d[KeyCode.ZERO]=')';
    
    d=GwenRenderer.KeyXlateDictCtrl;
    d[KeyCode.A]= "\x01";
    d[KeyCode.B]="\x02";
    d[KeyCode.C]="\x03";
    d[KeyCode.D]="\x04";
    d[KeyCode.E]="\x05";
    d[KeyCode.F]="\x06";
    d[KeyCode.G]='\x07';
    d[KeyCode.H]='\x08';
    d[KeyCode.I]='\x09';
    d[KeyCode.J]='\x0a';
    d[KeyCode.K]='\x0b';
    d[KeyCode.L]='\x0c';
    d[KeyCode.M]='\x0d';
    d[KeyCode.N]='\x0e';
    d[KeyCode.O]='\x0f';
    d[KeyCode.P]='\x10';
    d[KeyCode.Q]='\x11';
    d[KeyCode.S]='\x12';
    d[KeyCode.T]='\x13';
    d[KeyCode.U]='\x14';
    d[KeyCode.V]='\x15';
    d[KeyCode.X]='\x16';
    d[KeyCode.Y]='\x17';
    d[KeyCode.Z]='\x18';

  }
  
  double get Scale => _scale;
  set Scale(double value) { _scale = value; }
  

  
  void begin() 
  {
    RenderRequest request = _cvsr.requestRenderFrame();
    request.completer.future.then(doFrameComplete, onError: doFrameCompleteError);
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
  void drawFilledRect(Rectangle<int> r) 
  { 
    Rectangle rect = translateRect(r);
    _cvsr.drawFilledRectOnCanvas(rect);
  }
  void startClip()
  {
     _cvsr.clipCanvas(_clipRegion);
  }
  void endClip()
  {
    _cvsr.unclipCanvas();
  }
  void loadTextureKnownSize(GwenTexture t, int width, int height)
  {
    if(t.Name != null) t.HasData = true;
    t.Width = width;
    t.Height=height;
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
  
  
  void drawTexturedRect(GwenTexture t, Rectangle<int> r, [double u1=0.0, double v1=0.0, double u2=1.0, double v2=1.0])
  {
    Rectangle targetRect = translateRect(r);
    _cvsr.drawTexturedRectFromName(t.Name, targetRect, u1, v1, u2, v2);
  }
  
  void drawMissingImage(Rectangle<int> r, [String name="(unknown)"])
  {
    Rectangle rect = translateRect(r);
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
    _cvsr.drawTextOnCanvas( text, translateX(position.x), translateY(position.y) );
  }
  
  void drawLinedRect(Rectangle<int> r)
  {
     Rectangle rect = translateRect(r);
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
    if(texture.Name == _cvsr.NameSkinTexture)
    {
      return _cvsr.getSkinTexturePixelColor(x, y);
    } else
    {
      return defaultColor;
    }
    
  }
  
  void onMouseDownHandler(MouseEvent me)
  {
    if(_frameNumber == 0) return;
    int mx = me.client.x-_cvsr.ClientX;
    int my = me.client.y-_cvsr.ClientY;
    lastKnownMouseX = mx;
    lastKnownMouseY = my;
    _gwenCanvas.Input_MouseButton((me.button==2) ? 1 : 0, true);
  }
  
  void onMouseUpHandler(MouseEvent me)
  {
    if(_frameNumber == 0) return;
    int mx = me.client.x-_cvsr.ClientX;
    int my = me.client.y-_cvsr.ClientY;
    lastKnownMouseX = mx;
    lastKnownMouseY = my;
    _gwenCanvas.Input_MouseButton((me.button==2) ? 1 : 0, false);
  }
  
  void onMouseMoveHandler(MouseEvent me)
  {
    if(_frameNumber == 0) return;
    int mx = me.client.x-_cvsr.ClientX;
    int my = me.client.y-_cvsr.ClientY;
    if(g_bShiftKeyDown)
    {
      notifyRedrawRequested();
    }
    _gwenCanvas.Input_MouseMoved(mx, my,  mx-lastKnownMouseX, my-lastKnownMouseY );
    lastKnownMouseX = mx;
    lastKnownMouseY = my ;
  }
  
  static bool g_bShiftKeyDown=false;
  
  void onKeyDownHandler(KeyboardEvent ke)
  {
    if(_frameNumber == 0) return;
    _gwenCanvas.Input_Key(getGwenKeyFromEvent(ke), true);
    if(ke.shiftKey) GwenRenderer.g_bShiftKeyDown=true;
    if(ke.keyCode == KeyCode.SPACE) new Future(() { _gwenCanvas.Input_Character(" "); }); 
  }
  
  void onKeyUpHandler(KeyboardEvent ke)
  {
    if(_frameNumber == 0) return;
    _gwenCanvas.Input_Key(getGwenKeyFromEvent(ke), false);
    GwenRenderer.g_bShiftKeyDown = ke.shiftKey;
  }
  
  void onKeyPressHandler(KeyboardEvent ke)
  {
    
    if(_frameNumber == 0) return;
    _gwenCanvas.Input_Character(new String.fromCharCodes([ke.charCode]));
    /*
    int iKey = ke.keyCode;
    if(ke.ctrlKey)
    {
      if(GwenRenderer.KeyXlateDictCtrl.containsKey(iKey))
      {
        _gwenCanvas.Input_Character(GwenRenderer.KeyXlateDictCtrl[iKey]);
        return;
      }
    }
    if(ke.shiftKey)
    {
      if(GwenRenderer.KeyXlateDictShift.containsKey(iKey))
      {
        _gwenCanvas.Input_Character(GwenRenderer.KeyXlateDictShift[iKey]);
        return;
      }
    }
    if(GwenRenderer.KeyXlateDict.containsKey(iKey))
    {
      _gwenCanvas.Input_Character(GwenRenderer.KeyXlateDict[iKey]);
      return;
    }
    print("Unhandled key press 0x${ke.charCode.toRadixString(16)}");
    */
  }

  
  void connectEventsToGwenCanvas(GwenControlBase canvas)
  {
    _gwenCanvas = canvas;
    _cvsr.onMouseDown.listen(onMouseDownHandler);
    _cvsr.onMouseUp.listen(onMouseUpHandler);
    _cvsr.onMouseMove.listen(onMouseMoveHandler);
    _cvsr.onKeyDown.listen(onKeyDownHandler);
    _cvsr.onKeyUp.listen(onKeyUpHandler);
    _cvsr.onKeyPress.listen(onKeyPressHandler);
  }

  
  GwenKey getGwenKeyFromEvent(KeyboardEvent ke)
  {
     switch(ke.keyCode)
     {
       case KeyCode.BACKSPACE:
        return GwenKey.Backspace;
       case KeyCode.ENTER:
         return GwenKey.Return;
       case KeyCode.DELETE:
         return GwenKey.Delete;
       case KeyCode.LEFT:
         return GwenKey.Left;
       case KeyCode.RIGHT:
         return GwenKey.Right;
       case KeyCode.SHIFT:
         return GwenKey.Shift;
       case KeyCode.TAB:
         return GwenKey.Tab;
       case KeyCode.SPACE:
         return GwenKey.Space;
       case KeyCode.HOME:
         return GwenKey.Home;
       case KeyCode.END:
         return GwenKey.End;
       case KeyCode.CTRL:
         return GwenKey.Control;
       case KeyCode.UP:
         return GwenKey.Up;
       case KeyCode.DOWN:
         return GwenKey.Down;
       case KeyCode.ESC:
         return GwenKey.Escape;
       case KeyCode.ALT:
         return GwenKey.Alt;
       default:
         return GwenKey.Invalid;
     }
  }
  
  bool _bAlreadyRendering = false;
  bool _bRenderUpdateNeeded = true;
  void notifyRedrawRequested()
  {
    bool bCanRenderNow = (null != _gwenCanvas) && !_bAlreadyRendering;

    if(bCanRenderNow)
    {
      _bRenderUpdateNeeded = false;
      _bAlreadyRendering = true;
      _gwenCanvas.RenderCanvas();
      _bAlreadyRendering = false;
    } else
    {
      _bRenderUpdateNeeded = true;
      //if(_frameNumber > 10)
      //{
      //  _bRenderUpdateNeeded=true;
      //}
    }
  }
  

  
  void doFrameComplete(DateTime timeCompleted)
  {
     _cvsr.removeCompletedRenderRequestsFromQueue();


     /* Upon completing of some rendering, queue up another if need be. */
     if(_bRenderUpdateNeeded)
     {
       print("Frame $_frameNumber finished at $timeCompleted ($lastKnownMouseX, $lastKnownMouseY)");
       //new Future.delayed(new Duration(milliseconds: 50), notifyRedrawRequested);
       new Future(notifyRedrawRequested);
     } else
     {
       print("Frame $_frameNumber finished at $timeCompleted");
     }
     _frameNumber++;
  }
  
  void doFrameCompleteError(err, stacktrace)
  {
    print( "doFrameCompleteError called.  Err: $err, stacktrace: $stacktrace");
  }
  
  void SetCursor(CssCursor cursor)
  {
    _cvsr.setCursor(cursor.Name);
  }
  
}