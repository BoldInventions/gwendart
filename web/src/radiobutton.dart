part of gwendart;

class RadioButton extends CheckBox
{
   bool get AllowUncheck => false;
   
   RadioButton(GwenControlBase parent) : super(parent)
   {
     SetSize(15, 15);
     MouseInputEnabled = true;
     IsTabable = false;
     IsToggle = true;
   }
   
   void Render(GwenSkinBase skin)
   {
      skin.DrawRadioButton(this, IsChecked, IsDepressed);
   }
}