part of gwendart;

class ImagePanel extends GwenControlBase
{
  
   GwenTexture _texture;
   List<double> _uv;
   Color _drawColor;
   
   void SetUV(double u0, double v0, double u1, double v1)
   {
     _uv[0]=u0;
     _uv[1]=v0;
     _uv[2]=u1;
     _uv[3]=v1;
   }
   
   
   String get ImageName => _texture.Name;
   set ImageName(String value) 
   {
      _texture.load(value);
   }
   
   void Render(GwenSkinBase skin)
   {
     super.Render(skin);
     skin.Renderer.DrawColor = _drawColor;
     if(_texture.HasData)
     {
        skin.Renderer.drawTexturedRect(_texture, RenderBounds, _uv[0], _uv[1], _uv[2], _uv[3]);
     }
   }
   
   void SizeToContents()
   {
     SetSize(_texture.Width, _texture.Height);
   }
   
   bool OnKeySpace(bool down)
   {
      if(down)
      {
        super.OnMouseClickedLeft(0, 0, true);
      }
      return true;
   }
   
   ImagePanel(GwenControlBase parent) : super(parent)
   {
     _uv = new List<double>(4);
     SetUV(0.0, 0.0, 1.0, 1.0);
     _texture = new GwenTexture(Skin.Renderer);
     MouseInputEnabled=true;
     _drawColor=Color.White;
   }
}