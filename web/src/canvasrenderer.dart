part of gwendart;

class RenderRequest
{
  DateTime timeRequested;
  DateTime timeStarted;
  DateTime timeFinished;
  Completer<RenderRequest> completer;
  RenderRequest()
  {
    timeRequested = new DateTime.now();
    timeStarted = null;
    timeFinished = null;
    completer=new Completer<RenderRequest>();
  }
}

class CanvasRenderer
{
  
  static List<int> _listKeyCodesToPrevent=new List<int>();
  static const String TXC_BACKCLR = "#fff";
  static const String TXC_DEFTEXTCLR = "white";
  static const int TXC_CANV_WIDTH = 512;
  static const int TXC_CANV_HEIGHT = 512;
  bool IsRendering = false;
  
  CanvasElement _canvas;

  int _viewportWidth, _viewportHeight;

  Queue<RenderRequest> _renderRequestQueue=new Queue<RenderRequest>();
  bool _bTextureModified=true;

  CanvasElement _textureCanvas;
  var _varTextureCanvas;
  CanvasRenderingContext2D _txContext;
  int _txwidth;
  int _txheight;
  Color _color;
  
  CanvasElement _canvasSkinTexture;
  CanvasRenderingContext2D _txContextSkin;
  String _nameSkinTexture;
  Completer _completerSkinTexture;
  ImageElement _imageElementSkinTexture;
  
  HashMap<Object, ImageElement> _mapImageElements=new HashMap<Object, ImageElement>();
  List<Future> _listOfThingsToWaitFor = new List<Future>();
  
  
  

  

  
  Completer _textureLoadCompleter=new Completer();
  
  int get Width => _textureCanvas.width;
  int get Height => _textureCanvas.height;
  
  int get ClientX => _canvas.getBoundingClientRect().left.toInt();
  int get ClientY => _canvas.getBoundingClientRect().top.toInt();
  
  String get NameSkinTexture => _nameSkinTexture;
  
  bool get IsSkinTextureLoaded => _textureLoadCompleter.isCompleted;
  
  ElementStream<MouseEvent> get onClick => _canvas.onClick;
  ElementStream<KeyboardEvent> get onKeyDown => _canvas.onKeyDown;
  ElementStream<KeyboardEvent> get onKeyPress => _canvas.onKeyPress;
  ElementStream<KeyboardEvent> get onKeyUp => _canvas.onKeyUp;
  ElementStream<MouseEvent> get onMouseDown => _canvas.onMouseDown;
  ElementStream<MouseEvent> get onMouseEnter => _canvas.onMouseEnter;
  ElementStream<MouseEvent> get onMouseLeave => _canvas.onMouseLeave;
  ElementStream<MouseEvent> get onMouseMove => _canvas.onMouseMove;
  ElementStream<MouseEvent> get onMouseUp => _canvas.onMouseUp;
  ElementStream<WheelEvent> get onMouseWheel => _canvas.onMouseWheel;
  ElementStream<Event> get onFullscreenChange => _canvas.onFullscreenChange;
  ElementStream<Event> get onFullscreenError => _canvas.onFullscreenError;
  ElementStream<TouchEvent> get onTouchCancel => _canvas.onTouchCancel;
  ElementStream<TouchEvent> get onTouchEnd => _canvas.onTouchEnd;
  ElementStream<TouchEvent> get onTouchEnter => _canvas.onTouchEnter;
  ElementStream<TouchEvent> get onTouchLeave => _canvas.onTouchLeave;
  ElementStream<TouchEvent> get onTouchMove => _canvas.onTouchMove;
  ElementStream<TouchEvent> get onTouchStart => _canvas.onTouchStart;


  
   CanvasRenderer(CanvasElement displayCanvas, CanvasElement renderCanvas, CanvasElement canvasSkinTexture, String nameSkinTexture) {
    _canvas=displayCanvas;
    _canvas.tabIndex = -1;
    _canvas.focus();
    _nameSkinTexture = nameSkinTexture;
    _canvasSkinTexture= canvasSkinTexture;
    _canvasSkinTexture.width = 512;
    _canvasSkinTexture.height = 512;
    _txContextSkin=_canvasSkinTexture.getContext("2d");
    
    _textureCanvas = renderCanvas;
    _varTextureCanvas = _textureCanvas;
    _txwidth=_textureCanvas.width;
    _txheight = _textureCanvas.height;
    _textureCanvas.style.backgroundColor = TXC_BACKCLR;
    _textureCanvas.style.color = TXC_DEFTEXTCLR;
    _txContext = _textureCanvas.getContext("2d");


    _txContext.fillStyle = Color.Purple.StyleString;
    _txContext.fillRect(0, 0, _txwidth, _txheight);
    
    
    //double textWidth =_txContext.measureText("Hello, Canvas!").width;
    //double textHeight = _txContext.measureText("M").width * 1.2;
    //_txContext.fillStyle = "#000000";
    //_txContext.fillRect(0, _txheight - textHeight, textWidth, textHeight );
    
    _txContext.textAlign = "left";
    _txContext.textBaseline = "top";
    _txContext.fillStyle = TXC_DEFTEXTCLR;
    

    
    //_txContext.fillText("Hello, Canvas!", 0, _txheight-textHeight, _txwidth);

    _color = Color.Purple;
    
    _viewportWidth = _textureCanvas.width;
    _viewportHeight = _textureCanvas.height;
  }
  
  
  
  


  
  void onSkinTextureLoaded(e)
  {
    _txContextSkin.drawImage(_imageElementSkinTexture, 0, 0);
    _completerSkinTexture.complete();
  }
  
  Future _initSkinTexture()
  {
    _completerSkinTexture=new Completer();
    _imageElementSkinTexture = new Element.tag('img');
    _imageElementSkinTexture.onLoad.listen(onSkinTextureLoaded).onError( (e)
        {
            print("_initSkinTexture error!");
            _completerSkinTexture.completeError(e);
        });
    _imageElementSkinTexture.src = _nameSkinTexture;
    return _completerSkinTexture.future;
  }
  
  Future _initTexture() {
    ImageElement image = new Element.tag('img');
   // Texture2D t;
    image.onLoad.listen((e) {
      _textureLoadCompleter.complete();
    }).onError( (e) {
      print("_initTexture error!");
      _textureLoadCompleter.completeError(e);
      } );
    //image.src = "nehe.gif";
    //image.src = "512_rgbw_corners.png";
    image.src = "code512.png";
    return _textureLoadCompleter.future;
  }
  
  
  void drawMissingTexture(Rectangle<int> rect, String name)
  {
     Color clr = CurrentColor;
     CurrentColor = Color.Red;
     drawLineOnCanvas(rect.left, rect.top, rect.right, rect.bottom);
     drawLineOnCanvas(rect.left, rect.bottom, rect.right, rect.top);
     _txContext.strokeRect(rect.left, rect.top, rect.width, rect.height);
     drawTextOnCanvas("Err: '$name'", rect.left, (rect.top + rect.height/2).toInt());
     CurrentColor = clr;
  }
  
  void _drawTexturedRect(ImageElement elem, Rectangle<int> rect,  [double u1=0.0, double v1=0.0, double u2=1.0, double v2=1.0])
  {

    ///_txContext.drawImageScaledFromSource(
    //    elem, elem.width*u1, elem.height*v1, 
     //   (u2-u1)*elem.width, (v2-v1)*elem.height, rect.left, rect.top, rect.width, rect.height);
    if( (u1==0.0)&&(v1==0.0)&&(u2==1.0)&&(v2==1.0) )
    {
       _txContext.drawImageToRect(elem, rect /*, sourceRect: */);
    } else 
    {
       Rectangle srcRect = new Rectangle(
           elem.width * u1, elem.height*v1, elem.width*(u2-u1), elem.height*(v2-v1)
           );
       if( (srcRect.width<1) || (srcRect.height<1) || (srcRect.left<0) || (srcRect.top<0)
           ||(srcRect.left>=elem.width) || (srcRect.top>=elem.height)|| (srcRect.bottom < 0) || (srcRect.bottom>=elem.height)
           || (srcRect.right < 0) || (srcRect.right > elem.width))
       {
         return;
       }
       if(rect.width < 1) return;
       if(rect.height< 1) return;
       _txContext.drawImageToRect(elem,rect, sourceRect: srcRect);
    }
  }
  
  Point<int> getTextureSize(String name)
  {
    if( !_mapImageElements.containsKey(name))
    {
      return null;
    }
    ImageElement elem = _mapImageElements[name];
    return new Point(elem.width, elem.height);
  }
  
  Future<DateTime> preloadTexture(String name)
  {
    ImageElement elem;
    if(_mapImageElements.containsKey(name))
    {
       return new Future( () { return new DateTime.now(); });
    } else
    {
       Completer imageLoadCompleter = new Completer();
       elem = new Element.tag("img");
       elem.onLoad.listen( (e)
           {
             _mapImageElements[name] = elem;
             imageLoadCompleter.complete(new DateTime.now());
           }
       );
       elem.onError.listen(
           (e)
           {
             print("Texture Load of '$name' failed.");
             imageLoadCompleter.completeError(e);
           }
           );
       elem.src = name;
       return imageLoadCompleter.future;
    }
  }
  
  void drawTexturedRectFromName(String name, Rectangle<int> rect, [double u1=0.0, double v1=0.0, double u2=1.0, double v2=1.0])
  {
    ImageElement elem;
     if(!_mapImageElements.containsKey(name))
     {
        Completer imageLoadCompleter = new Completer();
        _listOfThingsToWaitFor.add(imageLoadCompleter.future);
        elem = new Element.tag('img');
        elem.onLoad.listen((e) {
          _mapImageElements[name] = elem;
          _drawTexturedRect(elem, rect, u1, v1, u2, v2);
          imageLoadCompleter.complete();
        }/* , onError: (err){
          imageLoadCompleter.completeError(err);
          print("texture laod '$name' failed. (A)");
        }*/ );
        elem.onError.listen( (err)
            {
              String shortName = name;
              if(name.length>20)
              {
                shortName = "#" + name.substring(name.length-20);
              }
          print("texture laod '$name' failed. (B)");
          drawMissingTexture(rect, shortName);
          imageLoadCompleter.completeError(err);
            });
        elem.src = name;
     } else
     {
        elem = _mapImageElements[name];
        
        _drawTexturedRect(elem, rect, u1, v1, u2, v2);
     }
  }
  
  void forgetTexture(String name)
  {
    _mapImageElements.remove(name);
  }
  
  
  num pwrTwoTextureSize(num targetValue)
  {
     num a = 4;
     while( a < targetValue )
     {
       a *= 2;
     }
     return a;
  }


  
  set CurrentColor( Color clr)
  {
    _txContext.fillStyle= clr.StyleString;
    _color = clr;
  }
  
  Color get CurrentColor => _color;
  
  Color getPixelColor(int x, int y)
  {
    int r;
    int g;
    int b;
    ImageData data = _txContext.getImageData(x, y, 1, 1);
    r = data.data[0].toInt();
    g = data.data[1].toInt();
    b = data.data[2].toInt();
    return new Color.rgb(r, g, b);
  }
  
  void start()
  {
    IsRendering = true;
    removeCompletedRenderRequestsFromQueue();
    if(_renderRequestQueue.length < 1) throw new StateError("CanvasRenderer._renderRequestQueue was empty");
    if(_renderRequestQueue.first.timeStarted != null) 
      throw new StateError("CanvasRenderer._renderRequestQueue first item was already started.");
    _renderRequestQueue.first.timeStarted = new DateTime.now();
    _txContext.fillStyle = "rgba(0, 0, 0, 0)";
    _txContext.fillRect(0, 0, _textureCanvas.width, _textureCanvas.height);
    _txContext.fillStyle = _color.StyleString;
    _txContext.save();
  }
  
  void unclipCanvas()
  {
    _txContext.restore();
    _txContext.beginPath();
    _txContext.rect(0, 0, _viewportWidth, _viewportHeight);
    _txContext.clip();
  }
  
  void clipCanvas(Rectangle<int> rect)
  {
    _txContext.restore();
    _txContext.save();
    _txContext.beginPath();
    _txContext.rect(rect.left, rect.top, rect.width, rect.height);
    _txContext.clip();
  }
  
  void drawPixelOnCanvas(int x, int y)
  {
     _txContext.fillRect(x, y, 1, 1);
     _bTextureModified=true;
  }
  
  void drawLinedRectOnCanvas(Rectangle<int> rect)
  {
    _txContext.strokeStyle = CurrentColor.StyleString;
    _txContext.beginPath();
    rawDrawLineOnCanvas(rect.left, rect.top, rect.right, rect.top);
    rawDrawLineOnCanvas(rect.right, rect.top, rect.right, rect.bottom);
    rawDrawLineOnCanvas(rect.right, rect.bottom, rect.left, rect.bottom);
    rawDrawLineOnCanvas(rect.left, rect.bottom, rect.left, rect.top);
    _txContext.stroke();
    _bTextureModified=true;
  }
  
  void drawFilledRectOnCanvas(Rectangle<int> rect)
  {
    _txContext.fillRect(rect.left, rect.top, rect.width, rect.height);
    _bTextureModified=true;
  }
  
  void rawDrawLineOnCanvas(int x0, int y0, int x1, int y1)
  {
    _txContext.moveTo(x0, y0);
    _txContext.lineTo(x1, y1);
  }
  
  void drawLineOnCanvas(int x0, int y0, int x1, int y1)
  {
    _txContext.strokeStyle = CurrentColor.StyleString;
    _txContext.beginPath();
    _txContext.moveTo(x0, y0);
    _txContext.lineTo(x1, y1);
    _txContext.stroke();
    _bTextureModified=true;
  }
  
  String _strCssFont=null;
  
  void setFont(String strCssFont)
  {
    _strCssFont = strCssFont;
  }
  
  Point<int> measureText(String str)
  {
    if(null != _strCssFont) 
    {
      if(_strCssFont != _txContext.font)
      {
        _txContext.font = _strCssFont;
      }
    }
    double textWidth =_txContext.measureText(str).width;
    double textHeight = _txContext.measureText("M").width * 1.2;
    return new Point<int>( textWidth.toInt(), textHeight.toInt());
  }
  
  void drawTextOnCanvas(String str, int x, int y)
  {
    if( null != str )
    {
      if(str.length > 0)
      {
        if(null != _strCssFont) 
          {
          if(_strCssFont != _txContext.font)
          {
          _txContext.font = _strCssFont;
        }
      }
    double textWidth =_txContext.measureText(str).width;
    double textHeight = _txContext.measureText("M").width * 1.2;
    
    num tWid = textWidth;
    num tH = textHeight;
    

    //_txContext.fillStyle = "#000000";
    //_txContext.fillRect(0, 0, textWidth, textHeight );
    
    _txContext.textAlign = "left";
    _txContext.textBaseline = "top";
    _txContext.fillStyle = CurrentColor.StyleString;
    

    
    _txContext.fillText(str, x, y, _txwidth);
    _bTextureModified=true;
      }
    }
  }
 
  


  Color getSkinTexturePixelColor(int x, int y)
  {
    int r;
    int g;
    int b;
    int a;
    ImageData data = _txContextSkin.getImageData(x, y, 1, 1);
    r = data.data[0].toInt();
    g = data.data[1].toInt();
    b = data.data[2].toInt();
    a = data.data[3].toInt();
    return new Color.argb(a, r, g, b);
  }

  
  Future initialize([List<String> listTextureNamesToPreload=null])
  {
    Completer multipleTextureCompleter = new Completer();
    Future futTexture1= _initTexture();
    Future futSkinTexture = _initSkinTexture();
    
    List<Future> listToWaitFor=new List<Future>();
    listToWaitFor.add(futTexture1);
    listToWaitFor.add(futSkinTexture);
    if(null != listTextureNamesToPreload)
    {
      for( String name in listTextureNamesToPreload)
      {
        listToWaitFor.add(preloadTexture(name));
      }
    }
    Future futBoth = Future.wait(listToWaitFor).then((e) {
       multipleTextureCompleter.complete();
    }).catchError((err) { multipleTextureCompleter.completeError(err); } );
    return multipleTextureCompleter.future;
  }
  
  void render()
  {
  }
  
  void flush()
  {

  }
  
  void _internalFinish(err)
  {
    try
    {
    _listOfThingsToWaitFor.clear();
    render();
    flush();
    _txContext.restore();
    _renderRequestQueue.first.timeFinished = new DateTime.now();
    } catch (err1, stacktrace)
    {
      _renderRequestQueue.first.timeFinished = new DateTime.now();
      _renderRequestQueue.first.completer.completeError(err1, stacktrace);
      IsRendering=false;
      return;
    }
    if(null != err)
    {
      _renderRequestQueue.first.completer.completeError(err);
    } else
    {
      _renderRequestQueue.first.completer.complete(_renderRequestQueue.first);
    }
    IsRendering=false;
  }
  
  void finish()
  {
    if(0!=_listOfThingsToWaitFor.length)
    {
      Future.wait(_listOfThingsToWaitFor).then((_){_internalFinish(null);}).catchError((err) {_internalFinish(err);});
    } else
    {
      _internalFinish(null);
    }
  }
  
  
  /**
   * Returns true if there is an unstarted render request in queue.
   */
  bool isUnstartedRenderRequestInQueue()
  {
    bool bUnstarted = _renderRequestQueue.length > 0;
    if(bUnstarted)
    {
      bUnstarted = _renderRequestQueue.last.timeStarted == null;
    }
    return bUnstarted;
  }
  
  /**
   * Should be called by the routine which runs when the completer
   * finishes, so that old stuff gets removed from the queue.
   */
  void removeCompletedRenderRequestsFromQueue()
  {
    if(_renderRequestQueue.length < 1) return;
    RenderRequest first = _renderRequestQueue.first;
    while(first.completer.isCompleted)
    {
       _renderRequestQueue.removeFirst();
       if(_renderRequestQueue.length < 1) break;
       first = _renderRequestQueue.first;
    }
  }
  
  /**
   * If there already is a request in the queue that hasn't been started,
   * this will simply update the request time to be more recent.  Otherwise,
   * it creates a new request into the queue and returns the request object.
   * This should be called before requesting the canvas to render.
   */
  RenderRequest requestRenderFrame()
  {
    bool bAddNew=_renderRequestQueue.length < 1;
    if(!bAddNew)
    {
      bAddNew = _renderRequestQueue.last.timeStarted != null;
    } 
    if(bAddNew)
    {
      _renderRequestQueue.addLast(new RenderRequest());
    } else
    {
      _renderRequestQueue.last.timeRequested = new DateTime.now();
    }
    return _renderRequestQueue.last;
  }
  
  void setCursor(String strCssCursor)
  {
    _canvas.style.cursor = strCssCursor;
  }
  

  
  void _preventBrowserKeyInterpretationHandler(KeyboardEvent ke)
  {
    if(_listKeyCodesToPrevent.contains(ke.keyCode))
    {
       ke.preventDefault();
    }
  }
  
  void preventBrowserKeyInterpretation()
  {
    if(!_listKeyCodesToPrevent.contains(KeyCode.BACKSPACE))
    {
    _listKeyCodesToPrevent.add(KeyCode.BACKSPACE);
    _listKeyCodesToPrevent.add(KeyCode.SPACE);
    _listKeyCodesToPrevent.add(KeyCode.HOME);
    _listKeyCodesToPrevent.add(KeyCode.END);
    _listKeyCodesToPrevent.add(KeyCode.PAGE_UP);
    _listKeyCodesToPrevent.add(KeyCode.PAGE_DOWN);
    _listKeyCodesToPrevent.add(KeyCode.UP);
    _listKeyCodesToPrevent.add(KeyCode.DOWN);
    _listKeyCodesToPrevent.add(KeyCode.LEFT);
    _listKeyCodesToPrevent.add(KeyCode.RIGHT);    
    }
    window.onKeyDown.listen(_preventBrowserKeyInterpretationHandler);
  }

}