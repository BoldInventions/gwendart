
part of gwendart;

class RenderRequest
{
  DateTime timeRequested;
  DateTime timeStarted;
  Completer<DateTime> completer;
  RenderRequest()
  {
    timeRequested = new DateTime.now();
    timeStarted = null;
    completer=new Completer<DateTime>();
  }
}

class CanvasRenderer
{
  CanvasElement _canvas;
  webgl.RenderingContext _gl;
  webgl.Program _shaderProgram;
  int _viewportWidth, _viewportHeight;
  
  webgl.Texture _neheTexture;
  bool _bTextureModified=true;
  
  webgl.Buffer _cubeVertexTextureCoordBuffer;
  webgl.Buffer _cubeVertexPositionBuffer;
  webgl.Buffer _cubeVertexIndexBuffer;
 
  Queue<RenderRequest> _renderRequestQueue=new Queue<RenderRequest>();
  
  
  
  Matrix4 _pMatrix;
  Matrix4 _mvMatrix;

  Queue<Matrix4> _mvMatrixStack;
  
  int _aVertexPosition;
  int _aTextureCoord;
  webgl.UniformLocation _uPMatrix;
  webgl.UniformLocation _uMVMatrix;
  webgl.UniformLocation _samplerUniform;
  
  int _dimensions = 3;
  
  bool bTextureLoaded=false;
  double clipleft;
  double clipright;
  double cliptop;
  double clipbottom;
  
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
  
  
  
  static const String TXC_BACKCLR = "#fff";
  static const String TXC_DEFTEXTCLR = "white";
  static const int TXC_CANV_WIDTH = 512;
  static const int TXC_CANV_HEIGHT = 512;
  
  webgl.Texture get TextureOfCanvas => _neheTexture;
  
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


  
  CanvasRenderer(CanvasElement canvas, CanvasElement canvasSkinTexture, String nameSkinTexture) {
    _canvas=canvas;
    _canvas.tabIndex = -1;
    _canvas.focus();
    _nameSkinTexture = nameSkinTexture;
    _canvasSkinTexture= canvasSkinTexture;
    _canvasSkinTexture.width = 512;
    _canvasSkinTexture.height = 512;
    _txContextSkin=_canvasSkinTexture.getContext("2d");
    
    _textureCanvas = querySelector("#textureCanvas");
    _varTextureCanvas = _textureCanvas;
    _txwidth=_textureCanvas.width = canvas.width;
    _txheight = _textureCanvas.height = canvas.height;
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
    
    _viewportWidth = canvas.width;
    _viewportHeight = canvas.height;
    _gl = canvas.getContext("experimental-webgl");
    clipleft = -_viewportWidth/2.0;
    clipright = _viewportWidth/2.0;
    cliptop = -_viewportHeight/2.0;
    clipbottom = _viewportHeight/2.0;
    _mvMatrixStack = new Queue();
    _initShaders();
    _initBuffers();

  }
  
  
  
  
  void _mvPushMatrix() {
    _mvMatrixStack.addFirst(_mvMatrix.clone());
  }

  void _mvPopMatrix() {
    if (0 == _mvMatrixStack.length) {
      throw new Exception("Invalid popMatrix!");
    }
    _mvMatrix = _mvMatrixStack.removeFirst();
  }
  

  void _initShaders() {
    // vertex shader source code. uPosition is our variable that we'll
    // use to create animation
    String vsSource = """
    attribute vec3 aVertexPosition;
    attribute vec2 aTextureCoord;
  
    uniform mat4 uMVMatrix;
    uniform mat4 uPMatrix;
  
    varying vec2 vTextureCoord;
  
    void main(void) {
      gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
      vTextureCoord = aTextureCoord;
    }
    """;
    
    // fragment shader source code. uColor is our variable that we'll
    // use to animate color
    String fsSource = """
    precision mediump float;

    varying vec2 vTextureCoord;

    uniform sampler2D uSampler;

    void main(void) {
      gl_FragColor = texture2D(uSampler, vec2(vTextureCoord.s, vTextureCoord.t));
    }
    """;
    
    // vertex shader compilation
    webgl.Shader vs = _gl.createShader(webgl.RenderingContext.VERTEX_SHADER);
    _gl.shaderSource(vs, vsSource);
    _gl.compileShader(vs);
    
    // fragment shader compilation
    webgl.Shader fs = _gl.createShader(webgl.RenderingContext.FRAGMENT_SHADER);
    _gl.shaderSource(fs, fsSource);
    _gl.compileShader(fs);
    
    // attach shaders to a WebGL program
    _shaderProgram = _gl.createProgram();
    _gl.attachShader(_shaderProgram, vs);
    _gl.attachShader(_shaderProgram, fs);
    _gl.linkProgram(_shaderProgram);

    
    /**
     * Check if shaders were compiled properly. This is probably the most painful part
     * since there's no way to "debug" shader compilation
     */
    if (!_gl.getShaderParameter(vs, webgl.RenderingContext.COMPILE_STATUS)) { 
      print(_gl.getShaderInfoLog(vs));
    }
    
    if (!_gl.getShaderParameter(fs, webgl.RenderingContext.COMPILE_STATUS)) { 
      print(_gl.getShaderInfoLog(fs));
    }
    
    if (!_gl.getProgramParameter(_shaderProgram, webgl.RenderingContext.LINK_STATUS)) { 
      print(_gl.getProgramInfoLog(_shaderProgram));
    }
    
    _aVertexPosition = _gl.getAttribLocation(_shaderProgram, "aVertexPosition");

    
    _aTextureCoord = _gl.getAttribLocation(_shaderProgram, "aTextureCoord");

    
    _uPMatrix = _gl.getUniformLocation(_shaderProgram, "uPMatrix");
    _uMVMatrix = _gl.getUniformLocation(_shaderProgram, "uMVMatrix");
    _samplerUniform = _gl.getUniformLocation(_shaderProgram, "uSampler");

  }
  
  void _initBuffers() {
    
    // variables to store verticies, tecture coordinates and colors
    List<double> vertices, textureCoords, colors;
    

    //_triangleVertexPositionBuffer.itemSize = 3;
    //_triangleVertexPositionBuffer.numItems = 3;
    
    // create square
    _cubeVertexPositionBuffer = _gl.createBuffer();
    _gl.bindBuffer(webgl.RenderingContext.ARRAY_BUFFER, _cubeVertexPositionBuffer);
    
    // fill "current buffer" with triangle verticies
    vertices = [
                clipleft, cliptop,  0.0,
                clipright, cliptop,  0.0,
                clipright,  clipbottom,  0.0,
                clipleft,  clipbottom,  0.0
    ];
    _gl.bufferDataTyped(webgl.RenderingContext.ARRAY_BUFFER, new Float32List.fromList(vertices), webgl.RenderingContext.STATIC_DRAW);
    _cubeVertexTextureCoordBuffer = _gl.createBuffer();
    _gl.bindBuffer(webgl.RenderingContext.ARRAY_BUFFER, _cubeVertexTextureCoordBuffer);
    textureCoords = [
        // Front face
        0.0, 0.0,
        1.0, 0.0,
        1.0, 1.0,
        0.0, 1.0,

    ];
    _gl.bufferDataTyped(webgl.RenderingContext.ARRAY_BUFFER, new Float32List.fromList(textureCoords), webgl.RenderingContext.STATIC_DRAW);
    
    _cubeVertexIndexBuffer = _gl.createBuffer();
    _gl.bindBuffer(webgl.RenderingContext.ELEMENT_ARRAY_BUFFER, _cubeVertexIndexBuffer);
    List<int> _cubeVertexIndices = [
         0,  1,  2,    0,  2,  3, // Front face
    ];
    _gl.bufferDataTyped(webgl.RenderingContext.ELEMENT_ARRAY_BUFFER, new Uint16List.fromList(_cubeVertexIndices), webgl.RenderingContext.STATIC_DRAW);
  }
  

  void _setMatrixUniforms() {
    Float32List tmpList = new Float32List(16);
    
    _pMatrix.copyIntoArray(tmpList);
    _gl.uniformMatrix4fv(_uPMatrix, false, tmpList);
    
    _mvMatrix.copyIntoArray(tmpList);
    _gl.uniformMatrix4fv(_uMVMatrix, false, tmpList);
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
    _neheTexture = _gl.createTexture();
    ImageElement image = new Element.tag('img');
   // Texture2D t;
    image.onLoad.listen((e) {
      _handleLoadedTexture(_neheTexture,   image );
      _gl.clearColor(0.0, 0.0, 0.0, 1.0);
      _gl.enable(webgl.RenderingContext.DEPTH_TEST);
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
  
  void _handleLoadedTexture(webgl.Texture texture,  ImageElement img ) {
    _gl.bindTexture(webgl.RenderingContext.TEXTURE_2D, texture);
    _gl.pixelStorei(webgl.RenderingContext.UNPACK_FLIP_Y_WEBGL, 1); // second argument must be an int
     _gl.texImage2DImage(webgl.RenderingContext.TEXTURE_2D, 0, webgl.RenderingContext.RGBA, 
        webgl.RenderingContext.RGBA, webgl.RenderingContext.UNSIGNED_BYTE, img); 

    _gl.texParameteri(webgl.RenderingContext.TEXTURE_2D, webgl.RenderingContext.TEXTURE_MAG_FILTER, webgl.RenderingContext.NEAREST);
    _gl.texParameteri(webgl.RenderingContext.TEXTURE_2D, webgl.RenderingContext.TEXTURE_MIN_FILTER, webgl.RenderingContext.NEAREST);
    _gl.bindTexture(webgl.RenderingContext.TEXTURE_2D, null);
    bTextureLoaded=true;
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
       _txContext.drawImageToRect(elem,rect, sourceRect: srcRect);
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
  }
  
  void clipCanvas(Rectangle<int> rect)
  {
    _txContext.restore();
    _txContext.save();
    _txContext.beginPath();
    _txContext.rect(rect.left, rect.top, rect.width, rect.height);
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
  
  void updateTextureFromCanvas()
  {

    if(_bTextureModified)
    {
    ImageData data = _txContext.getImageData(0, 0, _textureCanvas.width, _textureCanvas.height);


    if(data == null) throw new UnimplementedError("eek");
    
    /* Apply color key to make all pixels of a certain color be transparent. */
    Iterator<int> iter = data.data.iterator;
    int iPixel=0;
    while(iter.moveNext())
    {
      int r = iter.current;
      iter.moveNext();
      int g = iter.current;
      iter.moveNext();
      int b = iter.current;
      iter.moveNext();
      if( (r==255) && (b==255) && (g==0) )
      {
        data.data[iPixel*4 + 3] = 0;
      }
      iPixel++;
    }

    
    _gl.bindTexture(webgl.RenderingContext.TEXTURE_2D, _neheTexture);
    _gl.pixelStorei(webgl.RenderingContext.UNPACK_FLIP_Y_WEBGL, 1); // second argument must be an int
    /* _gl.texImage2DImage(webgl.RenderingContext.TEXTURE_2D, 0, webgl.RenderingContext.RGBA, 
        webgl.RenderingContext.RGBA, webgl.RenderingContext.UNSIGNED_BYTE, img); */
    /* _gl.texImage2D(webgl.RenderingContext.TEXTURE_2D, 0, webgl.RenderingContext.RGBA, 
        webgl.RenderingContext.RGBA, webgl.RenderingContext.UNSIGNED_BYTE, _textureCanvas); */
    _gl.texSubImage2DImageData(webgl.RenderingContext.TEXTURE_2D, 0, 
        0, 0, 
        webgl.RenderingContext.RGBA,
        webgl.RenderingContext.UNSIGNED_BYTE, data 
        );
    _gl.texParameteri(webgl.RenderingContext.TEXTURE_2D, webgl.RenderingContext.TEXTURE_MAG_FILTER, webgl.RenderingContext.NEAREST);
    _gl.texParameteri(webgl.RenderingContext.TEXTURE_2D, webgl.RenderingContext.TEXTURE_MIN_FILTER, webgl.RenderingContext.NEAREST);
    _gl.bindTexture(webgl.RenderingContext.TEXTURE_2D, null);
    
    _bTextureModified =false;
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

  
  Future initialize()
  {
    Completer multipleTextureCompleter = new Completer();
    Future futTexture1= _initTexture();
    Future futSkinTexture = _initSkinTexture();
    Future futBoth = Future.wait([futTexture1, futSkinTexture]).then((e) {
       multipleTextureCompleter.complete();
    }).catchError((err) { multipleTextureCompleter.completeError(err); } );
    return multipleTextureCompleter.future;
  }
  
  void render() {
    _gl.useProgram(_shaderProgram);
    _gl.enableVertexAttribArray(_aVertexPosition);
    _gl.enableVertexAttribArray(_aTextureCoord);
    _gl.viewport(0, 0, _viewportWidth, _viewportHeight);
    _gl.clear(webgl.RenderingContext.COLOR_BUFFER_BIT | webgl.RenderingContext.DEPTH_BUFFER_BIT);
    
    if(bTextureLoaded)
    {

     updateTextureFromCanvas();
    // field of view is 45°, width-to-height ratio, hide things closer than 0.1 or further than 100
 //   _pMatrix = makePerspectiveMatrix(radians(45.0), _viewportWidth / _viewportHeight, 0.1, 100.0);
    _pMatrix = makeOrthographicMatrix(clipleft, clipright-0.5, cliptop, clipbottom, 0.1, 256.0);
    
    _mvMatrix = new Matrix4.identity();
    _mvMatrix.translate(new Vector3(-0.5, 0.0, -0.2));

    
    

    
    _gl.bindBuffer(webgl.RenderingContext.ARRAY_BUFFER, _cubeVertexPositionBuffer);
    _gl.vertexAttribPointer(_aVertexPosition, _dimensions, webgl.RenderingContext.FLOAT, false, 0, 0);
    
    // texture
    _gl.bindBuffer(webgl.RenderingContext.ARRAY_BUFFER, _cubeVertexTextureCoordBuffer);
    _gl.vertexAttribPointer(_aTextureCoord, 2, webgl.RenderingContext.FLOAT, false, 0, 0);

    _gl.activeTexture(webgl.RenderingContext.TEXTURE0);
    _gl.bindTexture(webgl.RenderingContext.TEXTURE_2D, _neheTexture);
    _gl.uniform1i(_samplerUniform, 0);
    
    _gl.bindBuffer(webgl.RenderingContext.ELEMENT_ARRAY_BUFFER, _cubeVertexIndexBuffer);
    
    
    _setMatrixUniforms();
    //_gl.drawArrays(webgl.RenderingContext.TRIANGLE_STRIP, 0, 4); // square, start at 0, total 4
    _gl.drawElements(webgl.RenderingContext.TRIANGLES, 6, webgl.RenderingContext.UNSIGNED_SHORT, 0);
    _gl.disableVertexAttribArray(_aVertexPosition);
    _gl.disableVertexAttribArray(_aTextureCoord);
    _gl.useProgram(null);
    }
    
  }
  
  void flush()
  {
    _gl.flush();
  }
  
  void _internalFinish(err)
  {
    try
    {
    _listOfThingsToWaitFor.clear();
    render();
    flush();
    _txContext.restore();
    } catch (err1, stacktrace)
    {
      _renderRequestQueue.first.completer.completeError(err1, stacktrace);
      return;
    }
    if(null != err)
    {
      _renderRequestQueue.first.completer.completeError(err);
    }
    _renderRequestQueue.first.completer.complete(new DateTime.now());
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
  
  static List<int> _listKeyCodesToPrevent=new List<int>();
  
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



