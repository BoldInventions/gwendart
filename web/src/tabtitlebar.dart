part of gwendart;

class TabTitleBar extends Label
{
  TabTitleBar(GwenControlBase parent) : super(parent)
  {
     AutoSizeToContents = false;
     MouseInputEnabled = true;
     TextPadding = new GwenPadding(5, 2, 5, 2);
     Padding = new GwenPadding(1, 2, 1, 2);
     
     /// TODO: Implement Drag and Drop
     // DragAndDrop_SetPackage(true, "TabWindowMove");
  }
  
  void Render(GwenSkinBase skin)
  {
    skin.DrawTabTitleBar(this);
  }
  
  void DragAndDrop_StartDragging(GwenPackage package, int x, int y)
  {
    /// TODO: Implement Drag & Drop
    // DragAndDrop.SourceControl = Parent;
    // DragAndDrop.SourceControl.DragAndDrop_StartDragging(package, x, y);
  }
  
  void UpdateFromTab(TabButton button)
  {
    super.Text = button.Text;
    SizeToContents();
  }
  
}