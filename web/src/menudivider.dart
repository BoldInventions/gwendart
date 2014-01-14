part of gwendart;

class MenuDivider extends GwenControlBase
{
  MenuDivider(GwenControlBase parent) : super(parent)
  {
    Height = 1;
  }
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawMenuDivider(this);
  }
}