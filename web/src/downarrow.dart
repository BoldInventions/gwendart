part of gwendart;

class DownArrow extends GwenControlBase
{
   final ComboBox _comboBox;
   DownArrow(ComboBox parent) : _comboBox = parent,  super(parent)
   {
     MouseInputEnabled = false;
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawComboBoxArrow(this, _comboBox.IsHovered, _comboBox.IsDepressed, _comboBox.IsOpen, _comboBox.IsDisabled);
   }
}