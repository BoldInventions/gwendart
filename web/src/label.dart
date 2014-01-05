part of gwendart;


class MouseEventHandlerAddedHandler extends GwenEventHandler
{
   final Label _label;
  void Invoke(GwenControlBase willBeNull, GwenEventHandler handler)
  {
     _label.MouseInputEnabled = _label.ClickEventAssigned;
  }
  MouseEventHandlerAddedHandler(Label label) : _label=label
      {
    
      }
}

class Label extends GwenControlBase
{
   GwenText _text;
   Pos _align;
   GwenPadding _textPadding;
   bool _autoSizeToContents;
   MouseEventHandlerAddedHandler _mouseEventHandlerAddedHandler = null; 
   
   Pos get Alignment => _align;
   set Alignment (Pos value)
   {
     _align=value;
     Invalidate();
   }
   
   String get Text => _text.MyString;
   set Text (String value)
   {
     SetText(value);
   }
   
   GwenFont get Font => _text.Font;
   set Font (GwenFont value)
   {
     _text.Font = value;
     if(_autoSizeToContents) SizeToContents();
     Invalidate();
   }
   
   Color get TextColor => _text.TextColor;
   set TextColor (Color value) { _text.TextColor = value; }
   
   Color get TextColorOverride => _text.TextColorOverride;
   set TextColorOverride(Color value) { _text.TextColorOverride = value; }
   
   int get TextWidth=> _text.Width;
   
   int get TextX => _text.X;
   int get TextY => _text.Y;
   int get TextLength => _text.Length;
   int get TextRight => _text.Right;
   
   void MakeColorNormal() { TextColor = Skin.SkinColors.m_Label.Default; }
   void MakeColorBright() { TextColor = Skin.SkinColors.m_Label.Bright; }
   void MakeColorDark() { TextColor = Skin.SkinColors.m_Label.Dark; }
   void MakeColorHighLight() { TextColor = Skin.SkinColors.m_Label.Highlight; }
   
   
   bool get AutoSizeToContents => _autoSizeToContents;
   set AutoSizeToContents (bool value) { _autoSizeToContents=value; Invalidate(); }
   
   GwenPadding get TextPadding => _textPadding;
   set TextPadding (GwenPadding value) { _textPadding = value; Invalidate(); InvalidateParent(); }
   

   
   void SetText(String str, [bool doEvents = true])
   {
     if (Text == str)
       return;

     _text.MyString = str;
     if (_autoSizeToContents)
       SizeToContents();
     Invalidate();
     InvalidateParent();

     if (doEvents)
       OnTextChanged();
   }
   
   Point<int> GetClosestCharacter(int x, int y)
   {
     int px, py;
     Point pLocal  = _text.CanvasPosToLocal(new Point(x, y));
     px = _text.GetClosestCharacter(pLocal);
     py = 0;
     return new Point<int>(px, py);
   }
   
   void SetTextPosition(int x, int y)
   {
     _text.SetPosition(x, y);
   }
   
   void OnTextChanged() {}
   
   void SizeToContents()
   {
     _text.SetPosition(_textPadding.Left + Padding.Left, _textPadding.Top + Padding.Top);
     _text.SizeToContents();

     SetSize(_text.Width + Padding.Left + Padding.Right + _textPadding.Left + _textPadding.Right, 
         _text.Height + Padding.Top + Padding.Bottom + _textPadding.Top + _textPadding.Bottom);
     InvalidateParent();
   }
   
   void Layout(GwenSkinBase skin)
   {
     super.Layout(skin);
     Pos align = _align;
     if(_autoSizeToContents) SizeToContents();
     int x = _textPadding.Left + Padding.Left;
     int y = _textPadding.Top + Padding.Top;
     if (0 != (align.value & Pos.Right.value)) 
       x = Width - _text.Width - _textPadding.Right - Padding.Right;
     if (0 != (align.value & Pos.CenterH.value))
       x = ((_textPadding.Left + Padding.Left) + 
           ((Width - _text.Width - _textPadding.Left - Padding.Left - _textPadding.Right - Padding.Right) * 0.5)).round();

     if (0 != (align.value & Pos.CenterV.value))
       y = ((_textPadding.Top + Padding.Top) + ((Height - _text.Height) * 0.5) - _textPadding.Bottom - Padding.Bottom).round();
     if (0 != (align.value & Pos.Bottom.value)) 
       y = Height - _text.Height - _textPadding.Bottom - Padding.Bottom;

     _text.SetPosition(x, y);
   }
   
   
   Label(GwenControlBase parent) : super(parent)
   {
     _text = new GwenText(this);
     MouseInputEnabled = false;
     SetSize(100, 10);
     Alignment = new Pos( Pos.Top.value | Pos.Top.value);
     _autoSizeToContents=true;
     
     /* Add a handler so we can update MouseInputEnabled if somebody assigns a handler */
     _mouseEventHandlerAddedHandler = new MouseEventHandlerAddedHandler(this);
     
      HoverEnter.HandlerAddedNotifyHandler = _mouseEventHandlerAddedHandler;
      HoverLeave.HandlerAddedNotifyHandler = _mouseEventHandlerAddedHandler;
      Clicked.HandlerAddedNotifyHandler = _mouseEventHandlerAddedHandler;
      DoubleClicked.HandlerAddedNotifyHandler = _mouseEventHandlerAddedHandler;
      RightClicked.HandlerAddedNotifyHandler = _mouseEventHandlerAddedHandler;
      DoubleRightClicked.HandlerAddedNotifyHandler = _mouseEventHandlerAddedHandler;
      HoverEnter.HandlerRemovedNotifyHandler = _mouseEventHandlerAddedHandler;
      HoverLeave.HandlerRemovedNotifyHandler = _mouseEventHandlerAddedHandler;
      Clicked.HandlerRemovedNotifyHandler = _mouseEventHandlerAddedHandler;
      DoubleClicked.HandlerRemovedNotifyHandler = _mouseEventHandlerAddedHandler;
      RightClicked.HandlerRemovedNotifyHandler = _mouseEventHandlerAddedHandler;
      DoubleRightClicked.HandlerRemovedNotifyHandler = _mouseEventHandlerAddedHandler;
   }
   
}