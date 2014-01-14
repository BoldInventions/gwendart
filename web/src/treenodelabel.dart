part of gwendart;

class TreeNodeLabel extends Button
{
  TreeNodeLabel(GwenControlBase parent) : super(parent)
  {
    Alignment = new Pos(Pos.Left.value | Pos.CenterV.value);
    ShouldDrawBackground = false;
    Height = 16;
    TextPadding = new GwenPadding(3, 0, 3, 0);
  }
  
  void UpdateColors()
  {
    if(IsDisabled)
    {
      TextColor = Skin.SkinColors.m_Button.Disabled;
    } else if(IsDepressed || ToggleState)
    {
      TextColor = Skin.SkinColors.m_Tree.Selected;
    } else if(IsHovered)
    {
      TextColor = Skin.SkinColors.m_Tree.Hover;
    } else
    {
      TextColor = Skin.SkinColors.m_Tree.Normal;
    }
  }
}