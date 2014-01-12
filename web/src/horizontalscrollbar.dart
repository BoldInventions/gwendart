part of gwendart;

class HorizontalScrollBar extends ScrollBar
{
  int get BarSize => _bar.Width;
  set BarSize(int value) { _bar.Width = value; }
  
  int get BarPos => _bar.X - Height;
  
  int get ButtonSize => Height;
  
  bool get IsHorizontal => true;
  
  HorizontalScrollBar(GwenControlBase parent) : super(parent)
  {
    _bar.IsHorizontal = true;
    
    m_ScrollButton[0].SetDirectionLeft();
    m_ScrollButton[0].Clicked.add(new GwenScrollBarEventHandler(this, GwenScrollBarEventHandler.NUDGE_LEFT));
    m_ScrollButton[1].SetDirectionRight();
    m_ScrollButton[1].Clicked.add(new GwenScrollBarEventHandler(this, GwenScrollBarEventHandler.NUDGE_RIGHT));
    _bar.Dragged.add(new GwenScrollBarEventHandler(this, GwenScrollBarEventHandler.BAR_MOVED));
  }
  

  /// <summary>
  /// Lays out the control's interior according to alignment, padding, dock etc.
  /// </summary>
  /// <param name="skin">Skin to use.</param>
  void Layout(GwenSkinBase skin)
  {
    super.Layout(skin);

    m_ScrollButton[0].Width = Height;
    m_ScrollButton[0].Dock = Pos.Left;

    m_ScrollButton[1].Width = Height;
    m_ScrollButton[1].Dock = Pos.Right;

    _bar.Height = ButtonSize;
    _bar.Padding = new GwenPadding(ButtonSize, 0, ButtonSize, 0);

    double barWidth = 0.0;
    if (_contentSize > 0.0) barWidth = (_viewableContentSize/_contentSize)*(Width - (ButtonSize*2));

    if (barWidth < ButtonSize*0.5)
      barWidth = (ButtonSize ~/ 2).toDouble();

    _bar.Width =  barWidth.toInt();
    _bar.IsHidden = Width - (ButtonSize*2) <= barWidth;

    //Based on our last scroll amount, produce a position for the bar
    if (!_bar.IsHeld)
    {
      SetScrollAmount(ScrollAmount, true);
    }
  }

  void NudgeLeft(GwenControlBase control, GwenEventArgs args)
  {
    if (!IsDisabled)
      SetScrollAmount(ScrollAmount - NudgeAmount, true);
  }

  void NudgeRight(GwenControlBase control, GwenEventArgs args)
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
      if (clickPos.x < _bar.X)
        NudgeLeft(this, GwenEventArgs.Empty);
      else if (clickPos.x > _bar.X + _bar.Width)
        NudgeRight(this, GwenEventArgs.Empty);

      _depressed = false;
      InputHandler.MouseFocus = null;
    }
  }

  double CalculateScrolledAmount()
  {
    return (_bar.X - ButtonSize) / (Width - _bar.Width - (ButtonSize * 2));
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
      int newX = (ButtonSize + (value * ((Width - _bar.Width) - (ButtonSize * 2)))).toInt();
      _bar.MoveTo(newX, _bar.Y);
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