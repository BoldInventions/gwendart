part of gwendart;
class UpDownButtonDown extends Button
{
  UpDownButtonDown(GwenControlBase parent) : super(parent)
  {
    SetSize(7, 7);
  }
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawNumericUpDownButton(this, IsDepressed, false);
  }
}