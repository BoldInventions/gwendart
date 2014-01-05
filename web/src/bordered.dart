part of gwendart;

class SubRect
{
   List<double> uv;
   SubRect()
   {
     uv = new List<double>();
     uv.add(0.0);
     uv.add(0.0);
     uv.add(0.0);
     uv.add(0.0);
   }
}

class Bordered
{
  GwenTexture _Texture;
  final List<SubRect> _rects = new List<SubRect>();
  GwenMargin _margin;
  
  double _width;
  double _height;
  
  void SetRect(int num, double x, double y, double w, double h)
  {
    double texw = _Texture.Width.toDouble();
    double texh = _Texture.Height.toDouble();

    //x -= 1.0f;
    //y -= 1.0f;

    _rects[num].uv[0] = x / texw;
    _rects[num].uv[1] = y / texh;

    _rects[num].uv[2] = (x + w) / texw;
    _rects[num].uv[3] = (y + h) / texh;

    //  rects[num].uv[0] += 1.0f / m_Texture->width;
    //  rects[num].uv[1] += 1.0f / m_Texture->width;
  }
  void Init(GwenTexture texture, double x, double y, double w, double h, GwenMargin inMargin, [double drawMarginScale = 1.0])
  {
    _Texture = texture;

    _margin = inMargin;

    SetRect(0, x, y, _margin.Left.toDouble(), _margin.Top.toDouble());
    SetRect(1, x + _margin.Left, y, w - _margin.Left - _margin.Right, _margin.Top.toDouble());
    SetRect(2, (x + w) - _margin.Right, y, _margin.Right.toDouble(), _margin.Top.toDouble());

    SetRect(3, x, y + _margin.Top, _margin.Left.toDouble(), h - _margin.Top - _margin.Bottom);
    SetRect(4, x + _margin.Left, y + _margin.Top, w - _margin.Left - _margin.Right,
        h - _margin.Top - _margin.Bottom);
    SetRect(5, (x + w) - _margin.Right, y + _margin.Top, _margin.Right.toDouble(), h - _margin.Top - _margin.Bottom - 1);

    SetRect(6, x, (y + h) - _margin.Bottom, _margin.Left.toDouble(), _margin.Bottom.toDouble());
    SetRect(7, x + _margin.Left, (y + h) - _margin.Bottom, w - _margin.Left - _margin.Right, _margin.Bottom.toDouble());
    SetRect(8, (x + w) - _margin.Right, (y + h) - _margin.Bottom, _margin.Right.toDouble(), _margin.Bottom.toDouble());

    int left = (_margin.Left * drawMarginScale).round();
    int right = (_margin.Right * drawMarginScale).round();
    int top = (_margin.Top * drawMarginScale).round();
    int bottom = (_margin.Bottom * drawMarginScale).round();
    
    _margin = new GwenMargin(left, right, top, bottom);

    _width = w - x;
    _height = h - y;
  }
  
  Bordered.dbl(GwenTexture texture, 
      double x,
      double y,
      double w,
      double h,
      GwenMargin margin,
      [double drawMarginScale = 1.0]
  )
  {
    int i;
    for(i=0; i<9; i++)
    {
      SubRect subrect  = new SubRect();
      _rects.add(subrect);
    }
    Init(texture, x, y, w, h, margin, drawMarginScale);
  }
  
  Bordered(GwenTexture texture,
           int x, int y, int w, int h, GwenMargin margin)
  {
    double drawMarginScale = 1.0;
    int i;
    for(i=0; i<9; i++)
    {
      SubRect subrect  = new SubRect();
      _rects.add(subrect);
    }
    Init(texture, x.toDouble(), y.toDouble(), w.toDouble(), h.toDouble(), margin, drawMarginScale);
  }
  
  void DrawRect(GwenRendererBase render, int i, int x, int y, int w, int h)
  {
     render.drawTexturedRect(_Texture, new Rectangle<int>(x, y, w, h),
         _rects[i].uv[0],
         _rects[i].uv[1],
         _rects[i].uv[2],
         _rects[i].uv[3]);
  }
  
  void DrawR(GwenRendererBase render, Rectangle<int> r)
  {
     Draw(render, r, Color.White);
  }
  
  void Draw(GwenRendererBase render, Rectangle<int> r, [Color col = null])
  {
    if(_Texture == null) return;
    if(col==null) col = Color.White;
    render.DrawColor = col;
    if( (r.width < _width) && (r.height < _height))
    {
      render.drawTexturedRect(_Texture, r,
          _rects[0].uv[0],
          _rects[0].uv[1],
          _rects[0].uv[2],
          _rects[0].uv[3]);
      return;
    }
    
    DrawRect(render, 0, r.left, r.top, _margin.Left, _margin.Top);
    DrawRect(render, 1,   
        r.left +_margin.Left,
        r.top,
        r.width - _margin.Left - _margin.Right,
        _margin.Top);
    DrawRect(render, 2,
        r.left + r.width - _margin.Right,
        r.top,
        _margin.Right,
        _margin.Top
        );
    DrawRect(render, 3,
        r.left,
        r.top + _margin.Top,
        _margin.Left,
        r.height-_margin.Top - _margin.Bottom
        );
    DrawRect(render, 4,
        r.left + _margin.Left,
        r.top + _margin.Top,
        r.width - _margin.Left - _margin.Right,
        r.height - _margin.Top - _margin.Bottom
        );
    DrawRect(render, 5,
        r.left + r.width - _margin.Right,
        r.top + _margin.Top,
        _margin.Right,
        r.height - _margin.Top - _margin.Bottom
        );
    DrawRect(render, 6,
        r.left,
        r.top + r.height - _margin.Bottom,
        _margin.Left,
        _margin.Bottom
        );
    DrawRect(render, 7,
        r.left + _margin.Left,
        r.top + r.height - _margin.Bottom,
        r.width - _margin.Left - _margin.Right,
        _margin.Bottom
        );
    DrawRect(render, 8,
        r.left + r.width - _margin.Right,
        r.top+ r.height - _margin.Bottom,
        _margin.Right,
        _margin.Bottom);
  }
  
}