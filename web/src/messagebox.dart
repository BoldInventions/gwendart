part of gwendart;

class MessageBox extends WindowControl
{
  Button _button;
  Label _label;
  
  GwenEventHandlerList Dismissed = new GwenEventHandlerList();
  
  MessageBox(GwenControlBase parent, String text, [String caption=""]) : super(parent)
  {
    DeleteOnClose = true;
    _label = new Label(m_InnerPanel);
    _label.Text = text;
    _label.Margin = GwenMargin.Five;
    _label.Dock = Pos.Top;
    _label.Alignment  = Pos.Center;
    
    _button = new Button(m_InnerPanel);
    _button.Text = "OK";
    _button.Clicked.add(new GwenControlEventHandler(CloseButtonPressed));
    _button.Clicked.add(new GwenControlEventHandler(DismissedHandler));
    _button.Margin = GwenMargin.Five;
    _button.SetSize(50, 20);
    
    Align.Center(this);
    
  }
  
  void CloseButtonPressed(GwenControlBase control, GwenEventArgs args)
  {
    
  }
  
  void DismissedHandler(GwenControlBase control, GwenEventArgs args)
  {
    Dismissed.Invoke(this, args);
  }
  
  void Layout(GwenSkinBase skin)
  {
    super.Layout(skin);
    if((_button!=null) && (_label!=null))  // kds - must check because layout gets called before constructor finishes.
    {
    Align.PlaceDownLeft(_button, _label, 10);
    Align.CenterHorizontally(_button);
    m_InnerPanel.SizeToChildren();
    m_InnerPanel.Height += 10;
    SizeToChildren();
    } else
    {
      m_NeedsLayout=true;  // we couldn't layout this time so make sure we get laid the second time
    }
  }
  
  void Render(GwenSkinBase skin)
  {
    if((_button!=null) && (_label!=null))  // kds - must check because layout gets called before constructor finishes.
    {
      super.Render(skin);
    } else
    {
      Invalidate(); // since we couldn't render yet, make sure we know we need to render again later.
    }
  }
  
}