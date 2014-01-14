part of gwendart;

class UpDownButtonUp extends Button
{
  UpDownButtonUp(GwenControlBase parent) : super(parent)
  {
    SetSize(7, 7);
  }
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawNumericUpDownButton(this, IsDepressed, true);
  }
}