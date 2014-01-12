part of gwendart;

abstract class ScrollBar extends GwenControlBase
{
    List<ScrollBarButton> m_ScrollButton;
    ScrollBarBar _bar;
    
    bool _depressed;
    double _scrollAmount;
    double _contentSize;
    double _viewableContentSize;
    double _nudgeAmount;
    
    GwenEventHandlerList BarMoved = new GwenEventHandlerList();
    
    int get BarSize;
    set BarSize(int);
    
    int get BarPos;
    //set BarPos(int);
    
    
    int get ButtonSize => 0;
    
    double get NudgeAmount => _nudgeAmount/_contentSize;
    set NudgeAmount (double value)
    {
      _nudgeAmount = value;
    }
    
    double get ScrollAmount => _scrollAmount;
    double get ContentSize => _contentSize;
    set ContentSize(double value) 
    {
      if(_contentSize != value)
      {
           Invalidate();
      }
      _contentSize = value;
    }
    
    double get ViewableContentSize => _viewableContentSize;
    set ViewableContentSize(double value) 
    {
      if(_viewableContentSize != value)
      {
           Invalidate();
      }
      _viewableContentSize = value;
    }
    
    bool get IsHorizontal => false;
    
    ScrollBar(GwenControlBase parent) : super(parent)
    {
      m_ScrollButton=new List<ScrollBarButton>(2);
      m_ScrollButton[0] = new ScrollBarButton(this);
      m_ScrollButton[1] = new ScrollBarButton(this);
      
      _bar = new ScrollBarBar(this);
      _depressed = false;
      _scrollAmount=0.0;
      _contentSize = 1.0;
      _viewableContentSize=1.0;
      _nudgeAmount = 20.0;
      SetBounds(0, 0, 15, 15);

    }
    
    bool SetScrollAmount(double value, [bool forceUpdate = false])
    {
      if (_scrollAmount == value && !forceUpdate)
        return false;
      _scrollAmount = value;
      Invalidate();
      OnBarMoved(this, GwenEventArgs.Empty);
      return true;
    }
    
    void OnMouseClickedLeft(int x, int y, bool down)
    {
      
    }
    
    
    void Render(GwenSkinBase skin)
    {
      skin.DrawScrollBar(this, IsHorizontal, _depressed);
    }
    
    void OnBarMoved(GwenControlBase control, GwenEventArgs args)
    {
        BarMoved.Invoke(this, GwenEventArgs.Empty);
    }
    

    double CalculateScrolledAmount();
    void ScrollToLeft(){}
    void ScrollToRight(){}
    void ScrollToTop(){}
    void ScrollToBottom(){}
    
    
    
    
}