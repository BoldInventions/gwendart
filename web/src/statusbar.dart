part of gwendart;

class StatusBar extends Label
{
  StatusBar(GwenControlBase parent) : super(parent)
  {
    AutoSizeToContents = false;
    Height = 22;
    Dock = Pos.Bottom;
    Padding = GwenPadding.Two;
    Alignment = new Pos(Pos.Left.value | Pos.CenterV.value);
  }
  
  void AddControl(GwenControlBase control, bool right)
  {
    control.Parent = this;
    control.Dock = right ? Pos.Right : Pos.Left;
  }
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawStatusBar(this);
  }
}