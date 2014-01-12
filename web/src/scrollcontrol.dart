part of gwendart;

class GwenScrollControlEventHandler extends GwenEventHandler
{
   static const int VBAR_MOVED=0;
   static const int HBAR_MOVED=1;
   
   final ScrollControl _scrollControl;
   final int _code;
   GwenScrollControlEventHandler(ScrollControl scrollControl, int code) : _scrollControl = scrollControl, _code=code
       {
     
       }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
     switch(_code)
     {
       case VBAR_MOVED:
         _scrollControl.VBarMoved(control, args);
         break;
       case HBAR_MOVED:
         _scrollControl.HBarMoved(control, args);
         break;
       default:
         break;
     }
   }
}

class ScrollControl extends GwenControlBase
{
    bool _canScrollH;
    bool _canScrollV;
    bool _autoHideBars;
    
    int get VerticalScroll => m_InnerPanel.Y;
    int get HorizontalScroll => m_InnerPanel.X;
    
    GwenControlBase get InnerPanel => m_InnerPanel;
    
    ScrollBar _verticalScrollBar;
    ScrollBar _horizontalScrollBar;
    
    bool get CanScrollH => _canScrollH;
    bool get CanScrollV => _canScrollV;
    
    bool get AutoHideBars => _autoHideBars;
    set AutoHideBars (bool value) { _autoHideBars = value; }
    
    /// <summary>
    /// Initializes a new instance of the <see cref="ScrollControl"/> class.
    /// </summary>
    /// <param name="parent">Parent control.</param>
    ScrollControl(GwenControlBase parent) : super(parent)
    {
      MouseInputEnabled = false;

      _verticalScrollBar = new VerticalScrollBar(this);
      _verticalScrollBar.Dock = Pos.Right;
      _verticalScrollBar.BarMoved.add(new GwenScrollControlEventHandler(this, GwenScrollControlEventHandler.VBAR_MOVED));
      _canScrollV = true;
      _verticalScrollBar.NudgeAmount = 30.0;

      _horizontalScrollBar = new HorizontalScrollBar(this);
      _horizontalScrollBar.Dock = Pos.Bottom;
      _horizontalScrollBar.BarMoved.add(new GwenScrollControlEventHandler(this, GwenScrollControlEventHandler.HBAR_MOVED));
      _canScrollH = true;
      _horizontalScrollBar.NudgeAmount = 30.0;

      m_InnerPanel = new GwenControlBase(this);
      m_InnerPanel.SetPosition(0, 0);
      m_InnerPanel.Margin = GwenMargin.Five;
      m_InnerPanel.SendToBack();
      m_InnerPanel.MouseInputEnabled = false;

      _autoHideBars = false;
    }

    set HScrollRequired (bool value)
    {

        if (value)
        {
          _horizontalScrollBar.SetScrollAmount(0.0, true);
          _horizontalScrollBar.IsDisabled = true;
          if (_autoHideBars)
            _horizontalScrollBar.IsHidden = true;
        }
        else
        {
          _horizontalScrollBar.IsHidden = false;
          _horizontalScrollBar.IsDisabled = false;
        }
    }


    set VScrollRequired (bool value)
    {

        if (value)
        {
          _verticalScrollBar.SetScrollAmount(0.0, true);
          _verticalScrollBar.IsDisabled = true;
          if (_autoHideBars)
            _verticalScrollBar.IsHidden = true;
        }
        else
        {
          _verticalScrollBar.IsHidden = false;
          _verticalScrollBar.IsDisabled = false;
        }

    }

    /// <summary>
    /// Enables or disables inner scrollbars.
    /// </summary>
    /// <param name="horizontal">Determines whether the horizontal scrollbar should be enabled.</param>
    /// <param name="vertical">Determines whether the vertical scrollbar should be enabled.</param>
    void EnableScroll(bool horizontal, bool vertical)
    {
      _canScrollV = vertical;
      _canScrollH = horizontal;
      _verticalScrollBar.IsHidden = !_canScrollV;
      _horizontalScrollBar.IsHidden = !_canScrollH;
    }

    void SetInnerSize(int width, int height)
    {
      m_InnerPanel.SetSize(width, height);
    }

    void VBarMoved(GwenControlBase control, GwenEventArgs args)
    {
      Invalidate();
    }

    void HBarMoved(GwenControlBase control, GwenEventArgs args)
    {
      Invalidate();
    }

    /// <summary>
    /// Handler invoked when control children's bounds change.
    /// </summary>
    /// <param name="oldChildBounds"></param>
    /// <param name="child"></param>
    void OnChildBoundsChanged(Rectangle oldChildBounds, GwenControlBase child)
    {
      UpdateScrollBars();
    }

    /// <summary>
    /// Lays out the control's interior according to alignment, padding, dock etc.
    /// </summary>
    /// <param name="skin">Skin to use.</param>
    void Layout(GwenSkinBase skin)
    {
      UpdateScrollBars();
      super.Layout(skin);
    }

    /// <summary>
    /// Handler invoked on mouse wheel event.
    /// </summary>
    /// <param name="delta">Scroll delta.</param>
    /// <returns></returns>
    bool OnMouseWheeled(int delta)
    {
      if (CanScrollV && _verticalScrollBar.IsVisible)
      {
        if (_verticalScrollBar.SetScrollAmount(
            _verticalScrollBar.ScrollAmount - _verticalScrollBar.NudgeAmount * (delta / 60.0), true))
          return true;
      }

      if (CanScrollH && _horizontalScrollBar.IsVisible)
      {
        if (_horizontalScrollBar.SetScrollAmount(
          _horizontalScrollBar.ScrollAmount - _horizontalScrollBar.NudgeAmount * (delta / 60.0), true))
          return true;
      }

      return false;
    }

    /// <summary>
    /// Renders the control using specified skin.
    /// </summary>
    /// <param name="skin">Skin to use.</param>
    void Render(GwenSkinBase skin)
    {

    }

    void UpdateScrollBars()
    {
      if (m_InnerPanel == null)
        return;

      //Get the max size of all our children together
      int childrenWidth=0;
      int childrenHeight =0;
      for(GwenControlBase child in Children)
      {
        if(child.Right > childrenWidth) childrenWidth = child.Right;
        if(child.Bottom > childrenHeight) childrenHeight = child.Bottom;
      }
      
      //= Children.length > 0 ? Children.Max(x => x.Right) : 0;
      // Children.length > 0 ? Children.Max(x => x.Bottom) : 0;

      if (_canScrollH)
      {
        m_InnerPanel.SetSize(max(Width, childrenWidth), max(Height, childrenHeight));
      }
      else
      {
        m_InnerPanel.SetSize(Width - (_verticalScrollBar.IsHidden ? 0 : _verticalScrollBar.Width),
            max(Height, childrenHeight));
      }

      double wPercent = Width /
          (childrenWidth + (_verticalScrollBar.IsHidden ? 0 : _verticalScrollBar.Width));
      double hPercent = Height /
          (childrenHeight + (_horizontalScrollBar.IsHidden ? 0 : _horizontalScrollBar.Height));

      if (_canScrollV)
        VScrollRequired = hPercent >= 1;
      else
        _verticalScrollBar.IsHidden = true;

      if (_canScrollH)
        HScrollRequired = wPercent >= 1;
      else
        _horizontalScrollBar.IsHidden = true;


      _verticalScrollBar.ContentSize = m_InnerPanel.Height.toDouble();
      _verticalScrollBar.ViewableContentSize = (Height - (_horizontalScrollBar.IsHidden ? 0 : _horizontalScrollBar.Height)).toDouble();


      _horizontalScrollBar.ContentSize = m_InnerPanel.Width.toDouble();
      _horizontalScrollBar.ViewableContentSize = (Width - (_verticalScrollBar.IsHidden ? 0 : _verticalScrollBar.Width)).toDouble();

      int newInnerPanelPosX = 0;
      int newInnerPanelPosY = 0;

      if (CanScrollV && !_verticalScrollBar.IsHidden)
      {
        newInnerPanelPosY =
           (
                -((m_InnerPanel.Height) - Height + (_horizontalScrollBar.IsHidden ? 0 : _horizontalScrollBar.Height)) *
                _verticalScrollBar.ScrollAmount).toInt();
      }
      if (CanScrollH && !_horizontalScrollBar.IsHidden)
      {
        newInnerPanelPosX =
            (
                -((m_InnerPanel.Width) - Width + (_verticalScrollBar.IsHidden ? 0 : _verticalScrollBar.Width)) *
                _horizontalScrollBar.ScrollAmount).toInt();
      }

      m_InnerPanel.SetPosition(newInnerPanelPosX, newInnerPanelPosY);
    }

    void ScrollToBottom()
    {
      if (!CanScrollV)
        return;

      UpdateScrollBars();
      _verticalScrollBar.ScrollToBottom();
    }

    void ScrollToTop()
    {
      if (CanScrollV)
      {
        UpdateScrollBars();
        _verticalScrollBar.ScrollToTop();
      }
    }

    void ScrollToLeft()
    {
      if (CanScrollH)
      {
        UpdateScrollBars();
        _verticalScrollBar.ScrollToLeft();
      }
    }

    void ScrollToRight()
    {
      if (CanScrollH)
      {
        UpdateScrollBars();
        _verticalScrollBar.ScrollToRight();
      }
    }

    void DeleteAll()
    {
      m_InnerPanel.DeleteAllChildren();
    }
}