part of gwendart;

class GroupBox extends Label
{
  GroupBox(GwenControlBase parent) : super(parent)
  {
    AutoSizeToContents = false;
    MouseInputEnabled = true;
    KeyboardInputEnabled = true;
    TextPadding = new GwenPadding(10, 0, 10, 0);
    Alignment = new Pos(Pos.Top.value | Pos.Left.value);
    Invalidate();
    
    m_InnerPanel = new GwenControlBase(this);
    m_InnerPanel.Dock = Pos.Fill;
    m_InnerPanel.Margin = new GwenMargin(5, TextHeight+5, 5, 5);
  }
  
  void Layout(GwenSkinBase skin)
  {
    super.Layout(skin);
    if(AutoSizeToContents)
    {
      DoSizeToContents();
    }
  }
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawGroupBox(this, TextX, TextHeight, TextWidth);
  }
  
  /**
   * Override Label's size to contents or were going to have a bad time
   */
  void SizeToContents()
  {
    DoSizeToContents();
  }
  
  void DoSizeToContents()
  {
    m_InnerPanel.SizeToChildren();
    SizeToChildren();
    if (Width < TextWidth + TextPadding.Right + TextPadding.Left)
      Width = TextWidth + TextPadding.Right + TextPadding.Left;   
  }
}