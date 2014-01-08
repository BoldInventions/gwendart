part of gwendart;

class GwenText extends GwenControlBase
{
   static const int MaxCoord = 4096;
   String _string;
   GwenFont _font;
   
   int get Length => _string.length;
   Color TextColor;
   Color TextColorOverride;
   String TextOverride;
   
   GwenFont get Font => _font;
   set Font (GwenFont value)
   {
     _font=value;
     SizeToContents();
   }
   
   String get MyString => _string;
   set MyString (String value )
   {
     _string = value;
     SizeToContents();
   }
   
   void SizeToContents()
   {
     if (String == null)
       return;

     if (_font == null)
     {
       throw new ArgumentError("Text.SizeToContents() - No Font!!\n");
     }

     Point p = new Point(1, _font.Size);

     if (Length > 0)
     {
       p = Skin.Renderer.measureText(_font, null==TextOverride ? _string : TextOverride);
     }

     if (p.x == Width && p.y == Height)
       return;

     SetSize(p.x, p.y);
     Invalidate();
     InvalidateParent();
   }
   
   GwenText(GwenControlBase parent) : super(parent)
   {
     GwenSkinBase skin = Skin;
     _font = skin.DefaultFont;
     _string = "";

     TextColor = skin.SkinColors.m_Label.Default;
     MouseInputEnabled = false;
     TextColorOverride = new Color.argb(0, 255, 255, 255);
   }
   
   void Render(GwenSkinBase skin)
   {
     if(0==Length) return;
     if(null == Font) return;
     if(TextColorOverride.a == 0)
     {
       skin.Renderer.DrawColor = TextColor;
     } else
     {
       skin.Renderer.DrawColor = TextColorOverride;
     }
     skin.Renderer.renderText(Font, new Point<int>(0,0), (TextOverride!=null) ? TextOverride : _string);
   }
   
   void Layout(GwenSkinBase skin) { SizeToContents(); super.Layout(skin); }
   
   Point<int> GetCharacterPosition(int index)
   {
     if(0==Length || 0 == index) return new Point<int>(0,0);
     String sub = ((null != TextOverride) ? TextOverride : _string).substring(0, index);
     Point<int> p = new Point<int>(Skin.Renderer.measureText(Font, sub).x, 0);
   }
   
   static int abs(int a) 
   {
      if(a>=0) return a;
          return 0-a;
   }
   
   int GetClosestCharacter(Point p)
   {
     int distance = MaxCoord;
     int c = 0;

     for (int i = 0; i < _string.length + 1; i++)
     {
       Point cp = GetCharacterPosition(i);
       int dist = abs(cp.x - p.x) + abs(cp.y - p.y); // this isn't proper // [omeg] todo: sqrt

       if (dist > distance)
         continue;

       distance = dist;
       c = i;
     }

     return c;
   }
   
   
}