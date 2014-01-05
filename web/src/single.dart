part of gwendart;

class Single
{
  GwenTexture _Texture;
  List<double> _uv=[0.0, 0.0, 1.0, 1.0];
  int _width;
  int _height;
  
  Single(GwenTexture texture, num x, num y, num w, num h)
  {
    _Texture = texture;
    double texw = _Texture.Width.toDouble();
    double texh = _Texture.Height.toDouble();
    _uv[0] = x / texw;
    _uv[1] = y / texh;
    _uv[2] = (x+w) / texw;
    _uv[3] = (y+h) / texh;
    _width = w.toInt();
    _height = h.toInt();
  }
  
  void Draw(GwenRendererBase render, Rectangle<int> rect, [Color col=null])
  {
    if(col == null) col=Color.White;
    if(_Texture == null) return;
    render.DrawColor = col;
    render.drawTexturedRect(_Texture, rect, _uv[0], _uv[1], _uv[2], _uv[3]);
  }
  
  void DrawCenter(GwenRendererBase render, Rectangle<int> rect, [Color col = null])
  {
    if(null == col) col = Color.White;
    Rectangle<int> r= new Rectangle<int>(
        (0.5 * (rect.width - _width)).toInt(),
        (0.5 * (rect.height - _height)).toInt(),
        _width,
        _height
        );
    Draw(render, rect, col);
  }
}