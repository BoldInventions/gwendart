part of gwendart;

class GwenScrollBarEventHandler extends GwenEventHandler
{
   static const int NUDGE_UP=0;
   static const int NUDGE_DOWN=1;
   static const int NUDGE_LEFT=2;
   static const int NUDGE_RIGHT=3;
   static const int BAR_MOVED=4;
   
   final int _code;
   final ScrollBar _scrollBar;
   
   GwenScrollBarEventHandler(ScrollBar scrollBar, int code) : _code=code, _scrollBar = scrollBar
   {
     
   }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
     VerticalScrollBar vscrollBar=null;
     HorizontalScrollBar hscrollBar=null;
     if(_scrollBar is VerticalScrollBar)
     {
       vscrollBar = _scrollBar;
     }
     if(_scrollBar is HorizontalScrollBar)
     {
       hscrollBar = _scrollBar;
     }
     switch(_code)
     {
       case NUDGE_UP:
         vscrollBar.NudgeUp(control, args);
         break;
       case NUDGE_DOWN:
         vscrollBar.NudgeDown(control, args);
         break;
       case NUDGE_LEFT:
         hscrollBar.NudgeLeft(control, args);
         break;
       case NUDGE_RIGHT:
         hscrollBar.NudgeRight(control, args);
         break;
       case BAR_MOVED:
         _scrollBar.OnBarMoved(control, args);
         break;
       default:
         throw new ArgumentError("GwenScrollBarEventHandler code was illegal ($_code)");
     }
   }
}

class VerticalScrollBar extends ScrollBar
{
   int get BarSize => _bar.Height;
   set BarSize(int value) { _bar.Height = value; }
   
   int get BarPos => _bar.Y - Width;
   
   int get ButtonSize => Width;
   
   VerticalScrollBar(GwenControlBase parent) : super(parent)
   {
      _bar.IsVertical = true;
      
      m_ScrollButton[0].SetDirectionUp();
      m_ScrollButton[0].Clicked.add(new GwenScrollBarEventHandler(this, GwenScrollBarEventHandler.NUDGE_UP));
      m_ScrollButton[1].SetDirectionDown();
      m_ScrollButton[1].Clicked.add(new GwenScrollBarEventHandler(this, GwenScrollBarEventHandler.NUDGE_DOWN));
      _bar.Dragged.add(new GwenScrollBarEventHandler(this, GwenScrollBarEventHandler.BAR_MOVED));
   }
   

   /// <summary>
   /// Lays out the control's interior according to alignment, padding, dock etc.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Layout(GwenSkinBase skin)
   {
     super.Layout(skin);

     m_ScrollButton[0].Height = Width;
     m_ScrollButton[0].Dock = Pos.Top;

     m_ScrollButton[1].Height = Width;
     m_ScrollButton[1].Dock = Pos.Bottom;

     _bar.Width = ButtonSize;
     _bar.Padding = new GwenPadding(0, ButtonSize, 0, ButtonSize);

     double barHeight = 0.0;
     if (_contentSize > 0.0) barHeight = (_viewableContentSize/_contentSize)*(Height - (ButtonSize*2));

     if (barHeight < ButtonSize*0.5)
       barHeight = (ButtonSize ~/ 2).toDouble();

     _bar.Height =  barHeight.toInt();
     _bar.IsHidden = Height - (ButtonSize*2) <= barHeight;

     //Based on our last scroll amount, produce a position for the bar
     if (!_bar.IsHeld)
     {
       SetScrollAmount(ScrollAmount, true);
     }
   }

   void NudgeUp(GwenControlBase control, GwenEventArgs args)
   {
     if (!IsDisabled)
       SetScrollAmount(ScrollAmount - NudgeAmount, true);
   }

   void NudgeDown(GwenControlBase control, GwenEventArgs args)
   {
     if (!IsDisabled)
       SetScrollAmount(ScrollAmount + NudgeAmount, true);
   }

   void ScrollToTop()
   {
     SetScrollAmount(0.0, true);
   }

   void ScrollToBottom()
   {
     SetScrollAmount(1.0, true);
   }

   double get NudgeAmount
   {
       if (_depressed)
         return _viewableContentSize / _contentSize;
       else
         return super.NudgeAmount;
     }
     set NudgeAmount (double value)
     {
       super.NudgeAmount = value;
     }


   /// <summary>
   /// Handler invoked on mouse click (left) event.
   /// </summary>
   /// <param name="x">X coordinate.</param>
   /// <param name="y">Y coordinate.</param>
   /// <param name="down">If set to <c>true</c> mouse button is down.</param>
   void OnMouseClickedLeft(int x, int y, bool down)
   {
     super.OnMouseClickedLeft(x, y, down);
     if (down)
     {
       _depressed = true;
       InputHandler.MouseFocus = this;
     }
     else
     {
       Point clickPos = CanvasPosToLocal(new Point(x, y));
       if (clickPos.y < _bar.Y)
         NudgeUp(this, GwenEventArgs.Empty);
       else if (clickPos.y > _bar.Y + _bar.Height)
         NudgeDown(this, GwenEventArgs.Empty);

       _depressed = false;
       InputHandler.MouseFocus = null;
     }
   }

   double CalculateScrolledAmount()
   {
     return (_bar.Y - ButtonSize) / (Height - _bar.Height - (ButtonSize * 2));
   }

   /// <summary>
   /// Sets the scroll amount (0-1).
   /// </summary>
   /// <param name="value">Scroll amount.</param>
   /// <param name="forceUpdate">Determines whether the control should be updated.</param>
   /// <returns>True if control state changed.</returns>
   bool SetScrollAmount(double value, [bool forceUpdate = false])
   {
     value = GwenUtil.Clamp(value, 0.0, 1.0);

     if (!super.SetScrollAmount(value, forceUpdate))
       return false;

     if (forceUpdate)
     {
       int newY = (ButtonSize + (value * ((Height - _bar.Height) - (ButtonSize * 2)))).toInt();
       _bar.MoveTo(_bar.X, newY);
     }

     return true;
   }

   /// <summary>
   /// Handler for the BarMoved event.
   /// </summary>
   /// <param name="control">The control.</param>
   void OnBarMoved(GwenControlBase control, GwenEventArgs args)
   {
     if (_bar.IsHeld)
     {
       SetScrollAmount(CalculateScrolledAmount(), false);
       super.OnBarMoved(control, GwenEventArgs.Empty);
     }
     else
       InvalidateParent();
   }
}