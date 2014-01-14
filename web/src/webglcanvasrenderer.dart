
part of gwendart;



class WebglCanvasRenderer extends CanvasRenderer
{
  
  

  

  webgl.RenderingContext _gl;
  webgl.Program _shaderProgram;

  
  webgl.Texture _neheTexture;

  
  webgl.Buffer _cubeVertexTextureCoordBuffer;
  webgl.Buffer _cubeVertexPositionBuffer;
  webgl.Buffer _cubeVertexIndexBuffer;
 

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
  
  
  
  
  webgl.Texture get TextureOfCanvas => _neheTexture;
  




  
  WebglCanvasRenderer(CanvasElement displayCanvas, CanvasElement renderCanvas,
      CanvasElement canvasSkinTexture, 
      String nameSkinTexture) : super(displayCanvas, renderCanvas, canvasSkinTexture, nameSkinTexture)
      {

        

    _gl = displayCanvas.getContext("experimental-webgl");
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


  


  

  void updateTextureFromCanvas()
  {

    if(_bTextureModified)
    {
    ImageData data = _txContext.getImageData(0, 0, _textureCanvas.width, _textureCanvas.height);


    if(data == null) throw new UnimplementedError("eek");
    
    /* Apply color key to make all pixels of a certain color be transparent. */
    /*
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
    */
    
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
  


}



