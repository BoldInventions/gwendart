part of gwendart;

class ItemSelectedEventArgs extends GwenEventArgs
{
   final GwenControlBase _selectedItem;
   
   GwenControlBase get SelectedItem => _selectedItem;

   ItemSelectedEventArgs(GwenControlBase selectedItem) : _selectedItem = selectedItem
       {
     
       }
}