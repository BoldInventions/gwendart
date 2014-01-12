part of gwendart;

class ListBoxRow extends TableRow
{
  
  bool _selected;
  
  ListBoxRow(GwenControlBase parent) : super(parent)
  {
    MouseInputEnabled = true;
    IsSelected = false;
  }
  
  bool get IsSelected => _selected;
  set IsSelected(bool value) { _selected = value;  SetTextColor(value ? Color.White : Color.Black); }
  
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawListBoxLine(this, _selected, EvenRow);
  }
  
  void OnMouseClickedLeft(int x, int y, bool down)
  {
    super.OnMouseClickedLeft(x, y, down);
    if(down)
    {
      OnRowSelected();
    }
  }
  
  
}