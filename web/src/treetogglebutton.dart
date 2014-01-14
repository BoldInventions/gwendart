part of gwendart;

class TreeToggleButton extends Button
{
  TreeToggleButton(GwenControlBase parent) : super(parent)
  {
     IsToggle = true;
     IsTabable = true;
  }
  
  void RenderFocus(GwenSkinBase skin) {}
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawTreeButton(this, ToggleState);
  }
}